FROM python:3.11-slim

# 1. Przygotowanie środowiska (Jako ROOT)
WORKDIR /app
RUN useradd -m appuser

# 2. Instalacja zależności (Jako ROOT - cache'owanie!)
# Robimy to ZANIM skopiujemy kod, żeby nie przeinstalowywać bibliotek 
# przy każdej zmianie w main.py
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Kopiowanie kodu i ustawianie uprawnień (Jako ROOT)
COPY . .
RUN chown -R appuser:appuser /app

# 4. PRZEŁĄCZENIE NA UŻYTKOWNIKA (Ostatni krok przed startem)
USER appuser

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]