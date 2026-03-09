FROM python:3.11-slim

# 1. Katalog roboczy
WORKDIR /app

# 2. Instalacja zależności (jako ROOT, do ścieżek systemowych)
# Dzięki temu pytest będzie dostępny dla każdego
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Dodanie kodu
COPY main.py .
COPY test_main.py .

# 4. TWORZENIE UŻYTKOWNIKA i zmiana uprawnień do folderu /app
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

# Start aplikacji
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]