# User Documentation

## Overview

This project sets up a complete web infrastructure using Docker. It consists of three services running in isolated containers:

- **NGINX** — secure web server, the only entry point to the infrastructure (port 443, HTTPS)
- **WordPress** — content management system running with PHP-FPM
- **MariaDB** — relational database used by WordPress

All containers communicate through a private Docker network and data is persisted using Docker volumes.

---

## Starting the Project

To build and start all services:

```bash
make up
```

To stop all services without losing data:

```bash
make down
```

To start previously built containers:

```bash
make start
```

To stop running containers without removing them:

```bash
make stop
```

To restart all containers:

```bash
make restart
```

---

## Accessing the Website

Once the project is running, open your browser and navigate to:
https://mabi-nak.42.fr
> Since the project uses a self-signed TLS certificate, your browser will show a security warning. This is expected — click "Advanced" and proceed to the site.

Make sure your `/etc/hosts` file contains the following line:
127.0.0.1 mabi-nak.42.fr
If it doesn't, add it with:

```bash
echo "127.0.0.1 mabi-nak.42.fr" | sudo tee -a /etc/hosts
```

---

## Accessing the Admin Panel

The WordPress administration panel is available at:
https://mabi-nak.42.fr/wp-admin

Log in with the admin credentials defined during setup.

---

## Managing Credentials

All credentials are stored in two places:

- **`srcs/.env`** — database names, usernames, and passwords used by the containers
- **`secrets/`** — sensitive credential files (git-ignored, never committed)

| File | Contents |
|---|---|
| `secrets/credentials.txt` | WordPress admin username and password |
| `secrets/db_password.txt` | MariaDB user password |
| `secrets/db_root_password.txt` | MariaDB root password |

> Never share or commit these files. They are ignored by git intentionally.

---

## Checking That Services Are Running

To see the status of all containers:

```bash
make ps
```

All three containers (`nginx`, `wordpress`, `mariadb`) should show as `Up`.

To follow live logs from all containers:

```bash
make logs
```

To check logs for a specific service:

```bash
docker logs -f nginx
docker logs -f wordpress
docker logs -f mariadb
```

---

## Stopping and Cleaning Up

| Command | Effect |
|---|---|
| `make down` | Stop and remove containers, keep volumes and data |
| `make clean` | Stop containers and remove volumes (data will be lost) |
| `make fclean` | Full cleanup — containers, volumes, and images removed |
| `make re` | Full rebuild from scratch |

> Use `make clean` or `make fclean` with caution — they will delete all stored WordPress and database data.

---