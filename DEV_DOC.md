# Developer Documentation

## Overview

This project implements a containerized web infrastructure using Docker and Docker Compose. It includes three core services:

- **NGINX** — reverse proxy handling HTTPS (TLSv1.2 / TLSv1.3)
- **WordPress** — PHP-FPM application server
- **MariaDB** — relational database

Each service is built from a custom Dockerfile, runs in its own container, communicates through a dedicated Docker network, and stores persistent data using named Docker volumes.

---

## Prerequisites

Before setting up the project, ensure the following tools are installed:

- Docker
- Docker Compose (v2 recommended)
- Make

To verify installation:

```bash
docker --version
docker compose version
make --version
```

---

## Project Structure
. 
├── Makefile
├── README.md 
├── DEV_DOC.md 
├── USER_DOC.md 
├── secrets/ 
│ ├── credentials.txt 
│ ├── db_password.txt 
│ └── db_root_password.txt 
└── srcs/ 
├── .env 
├── docker-compose.yml 
└── requirements/ 
├── mariadb/ 
│ ├── Dockerfile 
│ ├── my.cnf 
│ └── script.sh 
├── nginx/ 
│ ├── Dockerfile 
│ ├── conf/default.conf 
│ └── script.sh 
└── wordpress/ 
├── Dockerfile 
├── script.sh 
└── wp-config.php

---

## Environment Configuration

The `srcs/.env` file holds all non-sensitive configuration. It must exist before running the project:

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=pass123
MYSQL_ROOT_PASSWORD=rootpass
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=pass123
WORDPRESS_DB_HOST=mariadb
```

> **Never commit `.env` or the `secrets/` directory to your repository.** Both must be in `.gitignore`.

---

## Secrets

Sensitive credentials are stored as plain text files inside the `secrets/` directory at the project root. This directory must be git-ignored.

| File | Contents |
|---|---|
| `credentials.txt` | WordPress admin credentials |
| `db_password.txt` | MariaDB user password |
| `db_root_password.txt` | MariaDB root password |

---

## Building and Launching the Project

The Makefile is the single entry point for all operations. It references `srcs/docker-compose.yml`.

### First-time setup

```bash
make up
```

This will:
1. Create host data directories at `/home/mabi-nak/data/mariadb` and `/home/mabi-nak/data/wordpress`
2. Build all three Docker images from their respective Dockerfiles
3. Start all containers in detached mode

### Stopping the project

```bash
make down      # stop and remove containers (volumes preserved)
make clean     # stop containers and remove volumes
make fclean    # full cleanup — containers, volumes, and images
```

### Rebuilding from scratch

```bash
make re
```

---

## Managing Containers

```bash
# View running containers
make ps

# Follow live logs from all containers
make logs

# Follow logs from a specific container
docker logs -f nginx
docker logs -f wordpress
docker logs -f mariadb

# Open a shell inside a container
docker exec -it nginx sh
docker exec -it wordpress sh
docker exec -it mariadb sh

# Restart all containers
make restart
```

---

## Managing Volumes

Named volumes store all persistent data. They are mapped to the host at `/home/mabi-nak/data/`.

| Volume | Host path | Contents |
|---|---|---|
| `mariadb_data` | `/home/mabi-nak/data/mariadb` | MariaDB database files |
| `wordpress_data` | `/home/mabi-nak/data/wordpress` | WordPress core files and uploads |

```bash
# List all Docker volumes
docker volume ls

# Inspect a volume
docker volume inspect srcs_mariadb_data

# Remove all volumes (destructive — data will be lost)
make clean
```

---

## Data Persistence

Data persists across container restarts because both volumes are bind-mounted to the host filesystem under `/home/mabi-nak/data/`. Even if containers are stopped or removed with `make down`, the data remains on disk. Only `make clean` or `make fclean` will remove the volumes and their data.

---

## Network

All containers communicate through a single bridge network called `inception_network`. Containers reference each other by service name:

- WordPress reaches MariaDB at `mariadb:3306`
- NGINX reaches WordPress at `wordpress:9000`

No ports other than `443` are exposed to the host.

---

## TLS Certificates

NGINX uses a self-signed certificate located at:

srcs/requirements/nginx/certs/certificate.crt
srcs/requirements/nginx/certs/certificate.key

 These are copied into the NGINX image at build time. When visiting `https://mabi-nak.42.fr` locally, you will need to accept the self-signed certificate warning in your browser.

---