*This project has been created as part of the 42 curriculum by mabi-nak.*

# Inception

## Description

Inception is a system administration project focused on designing and deploying a secure, modular web infrastructure using Docker and Docker Compose. Each service runs in its own isolated container, following strict constraints regarding security, networking, and data persistence.

The stack consists of three core services:
- **NGINX** — the sole entry point, handling HTTPS via TLSv1.2/TLSv1.3
- **WordPress + PHP-FPM** — the application layer, serving dynamic content
- **MariaDB** — the database layer, storing all WordPress data

---

## Project Description

### Why Docker over Virtual Machines?

Virtual Machines emulate an entire operating system including its kernel, making them heavy on resources and slow to spin up. Docker containers share the host kernel and isolate only the application layer, making them significantly lighter, faster to start, and easier to reproduce across environments. For this project, Docker allows each service to run in a clean, isolated environment without the overhead of a full VM per service.

### Secrets vs Environment Variables

Environment variables (stored in `.env`) are suitable for non-sensitive configuration like database names, hostnames, and ports. However, passwords and credentials should not live in `.env` files that could accidentally be committed to a repository. Docker secrets store sensitive data in memory-mounted files inside containers, never exposing them as environment variables in the process list. This project uses a `secrets/` directory (git-ignored) alongside `.env` for configuration.

### Docker Network vs Host Network

A Docker network (`inception_network`) creates an isolated virtual network where containers can communicate with each other by service name (e.g. `wordpress` can reach `mariadb` just by hostname). Host network mode removes this isolation and exposes all container ports directly on the host, which is a security risk and is explicitly forbidden by the subject. Using a bridge network ensures containers are isolated from the outside world except through explicitly defined ports.

### Docker Volumes vs Bind Mounts

Bind mounts link a specific host directory directly into the container — they depend on the host's directory structure and are less portable. Docker named volumes are managed by Docker itself and are more portable and explicit. This project uses named volumes with `driver_opts` to store data in `/home/mabi-nak/data/` on the host, satisfying the subject's requirement while keeping the compose file clean.

---

## Architecture
User (HTTPS) → NGINX :443 → WordPress PHP-FPM :9000 → MariaDB :3306

Data flow:
1. User accesses `https://mabi-nak.42.fr`
2. NGINX receives the request and terminates TLS
3. NGINX forwards PHP requests to WordPress via FastCGI
4. WordPress queries MariaDB for content
5. Response travels back through NGINX to the user

---

## Instructions

### Prerequisites

- Docker
- Docker Compose v2
- Make

### Setup

1. Clone the repository and navigate to the project root
2. Ensure the `.env` file exists at `srcs/.env` with the required variables
3. Add `mabi-nak.42.fr` to `/etc/hosts` pointing to `127.0.0.1`:
```bash
echo "127.0.0.1 mabi-nak.42.fr" | sudo tee -a /etc/hosts
```
4. Build and start all services:
```bash
make up
```
5. Access the site at `https://mabi-nak.42.fr`

### Available Make commands

| Command | Description |
|---|---|
| `make up` | Build images and start all containers |
| `make down` | Stop and remove containers |
| `make start` | Start existing containers |
| `make stop` | Stop containers without removing them |
| `make restart` | Restart all containers |
| `make logs` | Follow container logs |
| `make ps` | List running containers |
| `make clean` | Stop containers and remove volumes |
| `make fclean` | Full cleanup including images |
| `make re` | Full rebuild from scratch |

---

## Resources

- [Docker official documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [WordPress CLI (WP-CLI)](https://wp-cli.org/)
- [MariaDB documentation](https://mariadb.com/kb/en/)
- [PHP-FPM configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [TLS protocol overview — Mozilla](https://developer.mozilla.org/en-US/docs/Web/Security/Transport_Layer_Security)
- [PID 1 and Docker best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

### AI Usage

Claude (Anthropic) was used during this project to assist with:
- Reviewing `docker-compose.yml` syntax and named volume configuration
- Writing and correcting the WordPress startup script using WP-CLI
- Reviewing the NGINX configuration for TLS compliance
- Generating documentation (README, DEV_DOC, USER_DOC)

All AI-generated content was reviewed, tested, and understood before being included in the project.

---

