# ETAP 1: Builder
FROM python:3.11-slim AS builder

ENV PYROOT=/install
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .

# Instalacja zależności do dedykowanego folderu
RUN pip install --no-cache-dir --prefix=$PYROOT -r requirements.txt

# Przygotowanie plików aplikacji w folderze instalacyjnym
COPY main.py $PYROOT/main.py
COPY test_main.py .

# Testy: Dodajemy $PYROOT do ścieżki, aby testy widziały main.py i biblioteki
RUN PYTHONPATH=$PYROOT:$PYROOT/lib/python3.11/site-packages python3 -m pytest test_main.py

# ETAP 2: Final
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

# Konfiguracja ścieżek dla Distroless
ENV PYTHONPATH=/app/lib/python3.11/site-packages
ENV PATH=/app/bin:$PATH

# Jedna warstwa: Kopiujemy wszystko przygotowane w builderze
COPY --from=builder /install .

USER 65532
ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]