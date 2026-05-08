*This project has been created as part of the 42 curriculum by <your_login>.*

# Inception

## Introduction

Inception is a system administration project focused on designing and deploying a secure, modular web infrastructure using Docker and Docker Compose.

The objective is to build a multi-service architecture where each service runs in its own isolated container, following strict constraints regarding security, networking, and data persistence.

This project emphasizes:
- Containerization principles
- Service isolation
- Secure communication (HTTPS)
- Infrastructure reproducibility
- Best practices in DevOps and system design

---

## Project Objectives

The main goals of this project are:

- Build a complete web stack using Docker
- Configure each service manually using custom Dockerfiles
- Ensure secure communication using TLS (NGINX only on port 443)
- Maintain persistent data using Docker volumes
- Avoid pre-built images (except base Alpine/Debian)
- Use environment variables and secrets securely
- Implement proper container networking

---

## Architecture Overview

The infrastructure consists of three main services:

### NGINX (Reverse Proxy)
- Acts as the only entry point to the system
- Handles HTTPS connections using TLSv1.2 or TLSv1.3
- Forwards requests to the WordPress container
- Ensures secure external communication

---

### WordPress (Application Layer)
- Runs with PHP-FPM (no web server inside)
- Handles dynamic content generation
- Connects to the MariaDB database
- Stores website content in persistent storage

---

### MariaDB (Database Layer)
- Stores WordPress data (users, posts, settings)
- Initialized with predefined users
- Runs independently without any web server

---

## Data Flow

1. The user accesses the website via: https://mabi-nak.42.fr

2. The request reaches the **NGINX container**

3. NGINX forwards the request to **WordPress (PHP-FPM)**

4. WordPress communicates with **MariaDB** to fetch/store data

5. The response is sent back through NGINX to the user

---

## Installation & Usage

### Prerequisites

Ensure the following tools are installed:

- Docker
- Docker Compose (v2)
- Make

---

### Running the Project

Build and start all services:

```bash
make up