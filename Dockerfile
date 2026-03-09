# ETAP 1: Builder
FROM python:3.11-slim AS builder
WORKDIR /app

COPY requirements.txt .

# Instalujemy biblioteki do konkretnego folderu użytkownika
RUN pip install --no-cache-dir --user -r requirements.txt

# ETAP 2: Final (Distroless)
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# 1. Kopiujemy biblioteki zainstalowane przez pip w Stage 1
# Ścieżka w slim to zazwyczaj /root/.local/lib/python3.11/site-packages
COPY --from=builder /root/.local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /root/.local/bin /usr/local/bin

# 2. Kopiujemy kod
COPY main.py .
COPY test_main.py .

# 3. Ustawiamy PYTHONPATH, aby Distroless widział te biblioteki
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages
# Dodajemy też binaria do PATH, żeby uvicorn był widoczny
ENV PATH="/usr/local/bin:${PATH}"

# Użytkownik nonroot (UID 65532)
USER 65532

EXPOSE 8000

# Odpalamy uvicorn jako moduł Pythona
ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]