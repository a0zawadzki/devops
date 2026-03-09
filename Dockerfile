# ETAP 1: Builder
FROM python:3.11-slim AS builder

# Definiujemy zmienną, żeby nie wpisywać ścieżki ręcznie 5 razy
ENV PYROOT=/install
ENV PYTHONUSERBASE=$PYROOT

WORKDIR /app

COPY requirements.txt .

# Instalujemy biblioteki do naszego zdefiniowanego folderu
RUN pip install --no-cache-dir --user -r requirements.txt

# ETAP 2: Final
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# Ustawiamy tę samą zmienną, żeby Python wiedział gdzie szukać
ENV PYROOT=/install
ENV PYTHONPATH=$PYROOT/lib/python3.11/site-packages
ENV PATH=$PYROOT/bin:$PATH

# Teraz COPY wygląda znacznie czyściej - kopiujemy CAŁY nasz folder /install
COPY --from=builder /install /install

COPY main.py .
COPY test_main.py .

USER 65532
ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]