# ETAP 1: Builder
FROM python:3.11-slim AS builder

ENV PYROOT=/install
ENV PYTHONUSERBASE=$PYROOT
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .

# Instalacja zależności i przygotowanie testów
RUN pip install --no-cache-dir --prefix=$PYROOT -r requirements.txt

COPY . .
# URUCHAMIAMY TESTY TUTAJ - Jeśli zawiodą, obraz nie zostanie zbudowany
RUN python3 -m pytest test_main.py

# ETAP 2: Final
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# Środowisko
ENV PYTHONPATH=/install/lib/python3.11/site-packages
# Distroless python3-debian12 nie ma /bin/sh, więc PATH musi być precyzyjne
ENV PATH=/install/bin:$PATH

# Kopiujemy wszystko jednym strzałem (zależności + kod źródłowy bez testów)
COPY --from=builder /install /install
COPY main.py .

USER 65532
# Używamy modułu uvicorn bezpośrednio
ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]