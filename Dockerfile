# ETAP 1: Builder
FROM python:3.11-slim AS builder

ENV PYROOT=/install
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=$PYROOT -r requirements.txt

# Kopiujemy kod do folderu, który i tak będziemy przenosić
COPY main.py $PYROOT/main.py
COPY test_main.py .

# Testy (nadal używamy bibliotek z /install)
RUN PYTHONPATH=$PYROOT:$PYROOT/lib/python3.11/site-packages python3 -m pytest test_main.py

# ETAP 2: Final
FROM python:3.11-slim

RUN useradd -m -u 1000 appuser
WORKDIR /app

# Ustawiamy ścieżki tak, by Python szukał bibliotek I kodu w /app
ENV PYTHONPATH=/app/lib/python3.11/site-packages
ENV PATH=/app/bin:$PATH

# --- JEDEN COPY, JEDNA WARSTWA ---
# Kopiujemy zawartość /install bezpośrednio do /app z poprawnym właścicielem
COPY --from=builder --chown=appuser:appuser /install .

USER appuser
ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]