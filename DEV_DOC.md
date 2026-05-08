# DEVELOPER DOCUMENTATION

## 📌 Overview
This project implements a containerized web infrastructure using Docker and Docker Compose. It includes three core services:

- **NGINX** (reverse proxy with HTTPS)
- **WordPress** (PHP-FPM application)
- **MariaDB** (database server)

Each service is built from a custom Dockerfile and runs in its own container. Services communicate through a dedicated Docker network, and persistent data is stored using Docker volumes.

---

## ⚙️ Prerequisites

Before setting up the project, ensure the following tools are installed:

- Docker
- Docker Compose (v2 recommended)
- Make

To verify installation:

```bash
docker --version
docker compose version
make --version