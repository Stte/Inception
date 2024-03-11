# Inception

This project implements a System Administration exercise using Docker. It virtualizes several microservices: MariaDB, Wordpress and NGINX setup for a Linux machine using Docker and docker-compose, build from scratch.

---

## 🚀 **Project Overview:**

- The project sets up a small infrastructure composed of different services within a virtual machine using Docker Compose.
- Each service runs in its own dedicated container.
- Dockerfiles for each service are written and called in the docker-compose.yml using the Makefile.
- Docker images are built from scratch rather than pulling ready-made ones.
- The project includes:
  - NGINX container with TLSv1.2 or TLSv1.3.
  - WordPress + php-fpm container without nginx.
  - MariaDB container without nginx.
  - Volumes for WordPress database and website files.
  - Docker network to connect containers.
- Containers are configured to restart on crash.
