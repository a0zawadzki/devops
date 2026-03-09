FROM python:3.11-slim

# 1. Przygotowanie środowiska (Jako ROOT)
WORKDIR /app
RUN useradd -m appuser

# 2. Instalacja zależności (Cache'owanie warstw)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

# 3. Kopiowanie kodu Z ODRAZU z poprawnym właścicielem
# To oszczędza miejsce w obrazie i jest bezpieczniejsze
COPY --chown=appuser:appuser . .

# 4. PRZEŁĄCZENIE NA UŻYTKOWNIKA
USER appuser

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]