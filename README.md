# 🤖 Pancerne FastAPI - AI-Driven DevOps Showcase

![CI/CD Pipeline](https://github.com/a0zawadzki/devops/actions/workflows/test-develop.yml/badge.svg?branch=develop)
![Docker Image](https://img.shields.io/badge/docker-ghcr.io-blue?logo=docker)
![AI-Powered](https://img.shields.io/badge/vibe-coding-blueviolet?logo=google-gemini&logoColor=white)

Projekt typu **Full AI Project Vibe**, gdzie granica między kodowaniem a architekturą zaciera się dzięki współpracy człowieka z AI. To nie jest zwykłe "Hello World" – to poligon doświadczalny dla najbezpieczniejszych metod konteneryzacji (Distroless, Non-root) i zautomatyzowanego cyklu życia aplikacji.

## 🌟 Bajery (The AI Edge)

* **Vibe Coding Strategy:** Projekt zbudowany w ścisłej pętli zwrotnej z AI, co pozwoliło na błyskawiczne wdrożenie rygorystycznych standardów bezpieczeństwa.
* **Pro Versioning:** Automatyczne tagowanie semantyczne (`v0.1.x`) przy każdym udanym pushu. Nie ma miejsca na chaos.
* **Zero-Trust Containers:** * **Non-root:** Brak uprawnień roota wewnątrz kontenera (UID 1000).
    * **Distroless:** Całkowite usunięcie powłoki i zbędnych binarek na gałęzi `feature/distroless-docker`.

## 🏗️ Architektura CI/CD

Każda zmiana w kodzie przechodzi przez "Sito Jakości":
1.  **Unit Tests:** Szybka weryfikacja logiki przez `pytest`.
2.  **Smoke Test:** Automatyczny rozruch kontenera i sprawdzenie `curl` na żywym organizmie.
3.  **GHCR Push:** Tylko 100% sprawne obrazy trafiają do rejestru.

Monitoruj akcje na żywo: [GitHub Actions Dashboard](https://github.com/a0zawadzki/devops/actions)

## 🚀 Szybki Start

### Pobranie gotowego obrazu (Latest Stable)
```bash
docker pull ghcr.io/a0zawadzki/hello-app:latest