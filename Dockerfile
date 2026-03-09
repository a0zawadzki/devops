# Wybieramy lekką bazę Pythona
FROM python:3.11-slim

# 1. POLITYKA BEZPIECZEŃSTWA: Tworzymy systemową grupę i użytkownika
# Nie chcemy, aby procesy wewnątrz kontenera miały uprawnienia administratora (root)
RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -m -s /bin/bash appuser

# 2. Ustawiamy katalog roboczy i właściciela
WORKDIR /home/appuser/app

# 3. Kopiujemy plik zależności i instalujemy je
COPY --chown=appuser:appgroup requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# 4. Kopiujemy resztę kodu (aplikację i testy)
COPY --chown=appuser:appgroup main.py .
COPY --chown=appuser:appgroup test_main.py .

# 5. Dodajemy ścieżkę do binariów zainstalowanych przez użytkownika do PATH
ENV PATH="/home/appuser/.local/bin:${PATH}"

# 6. PRZEŁĄCZAMY SIĘ NA UŻYTKOWNIKA (To jest kluczowy moment!)
USER 10001

# Port, na którym nasłuchuje FastAPI
EXPOSE 8000

# Start aplikacji
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]