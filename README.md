# 🤖 Pancerne FastAPI - AI-Driven DevOps Showcase

![CI/CD Pipeline](https://github.com/a0zawadzki/devops/actions/workflows/dev-prod.yml/badge.svg?branch=develop)
![Docker Image](https://img.shields.io/badge/docker-ghcr.io-blue?logo=docker)
![AI-Powered](https://img.shields.io/badge/vibe-coding-blueviolet?logo=google-gemini&logoColor=white)

Projekt typu **Full AI Project Vibe**, gdzie granica między kodowaniem a architekturą zaciera się dzięki współpracy człowieka z AI (Gemini). To nie jest zwykłe "Hello World" – to poligon doświadczalny dla najbezpieczniejszych metod konteneryzacji i zautomatyzowanego cyklu życia aplikacji.

## 🌟 Bajery (The AI Edge & Engineering)

* **Vibe Coding Strategy:** Architektura zaprojektowana w ścisłej pętli zwrotnej z AI, co pozwoliło na błyskawiczne wdrożenie rygorystycznych standardów bezpieczeństwa bez długu technicznego.
* **Extreme Optimization (Single-Layer Copy):** Zastosowanie techniki konsolidacji plików w etapie `Builder`. Obraz finalny zawiera **tylko jedną warstwę danych**, co redukuje narzut systemu plików i przyspiesza start kontenera.
* **Turbo CI/CD (GHA Caching):** Implementacja `Docker Buildx` z cachem typu `gha` (GitHub Actions) oraz `pip cache`. Buildy po zmianie kodu trwają sekundy, a nie minuty.
* **Zero-Trust Containers:**
    * **Distroless (`main`/`develop`):** Najwyższy poziom izolacji. Brak powłoki (shell), brak managera pakietów, brak zbędnych binarek. Atakujący nie ma punktu zaczepienia.
    * **Non-root (`feature/docker-nonroot`):** Rygorystyczna izolacja użytkownika (UID 1000) na bazie obrazów Debian Slim.
* **Pro Versioning:** Automatyczne tagowanie semantyczne (`v1.x.x`) przy każdym udanym pushu. Pełna kontrola nad historią wydań.



## 🏗️ Architektura CI/CD - "Sito Jakości"

Każda zmiana przechodzi przez wielopoziomową weryfikację:

1.  **Unit Tests (GHA):** Izolowane testy `pytest` uruchamiane natychmiast po pushu z wykorzystaniem cache'owania paczek pip.
2.  **Internal Docker Tests:** Ponowne uruchomienie testów wewnątrz `Dockerfile (Stage: Builder)`. Jeśli testy nie przejdą wewnątrz izolowanego kontenera, obraz w ogóle nie zostanie zbudowany.
3.  **Smoke Test:** Automatyczny rozruch gotowego kontenera w środowisku CI i weryfikacja `curl` na "żywym organizmie" przed wypchnięciem do rejestru.
4.  **Semantic Versioning:** Automatyczna publikacja do **GitHub Container Registry (GHCR)** tylko dla obrazów, które przeszły wszystkie testy.



Monitoruj akcje na żywo: [GitHub Actions Dashboard](https://github.com/a0zawadzki/devops/actions)

## 🚀 Szybki Start

### Pobranie gotowego obrazu (Latest Stable)
```bash
docker pull ghcr.io/a0zawadzki/hello-app:latest
```
### ⚡ Uruchomienie lokalne (Dev/Debug)
Wykorzystaj Docker Compose z pełnym hardeningiem (ReadOnly FS, Cap Drop, Resource Limits):
```bash
docker-compose up --build
```