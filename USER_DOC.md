# USER DOCUMENTATION

## 📌 Overview
This project sets up a complete web infrastructure using Docker. It consists of three main services:

- **NGINX**: A secure web server handling HTTPS connections (TLSv1.2 / TLSv1.3)
- **WordPress**: A content management system running with PHP-FPM
- **MariaDB**: A relational database used by WordPress

Each service runs in its own container, and all containers communicate through a Docker network.

---

## 🚀 Starting the Project

To build and start all services, run:

```bash
make up