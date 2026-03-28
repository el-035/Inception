*This project has been created as part of the 42 curriculum by efittant.*

# Inception

## Description

This project is a small web infrastructure built with Docker. It runs a WordPress website with NGINX and a MariaDB database.

The goal is to build the services with custom `Dockerfile`s and run them together with Docker Compose.

### Project Description

The project is built around three services:

- `nginx`: built from [`srcs/requirements/nginx/Dockerfile`]. It listens on `443`, uses a self-signed certificate, and sends PHP requests to WordPress.
- `wordpress`: built from [`srcs/requirements/wordpress/Dockerfile`]. It runs WordPress with PHP-FPM.
- `mariadb`: built from [`srcs/requirements/mariadb/Dockerfile`]. It stores the WordPress database.

The services are connected in [`srcs/docker-compose.yml`]. The Makefile gives simple commands to build, start, stop, and remove the project.

### Main Design Choices

- Each main service has its own image built from Debian 12.
- Only NGINX is exposed to the host on port `443`.
- WordPress and MariaDB keep their data in volumes so it is not lost when containers are recreated.
- TLS is enabled with a self-signed certificate generated during the NGINX image build.

### Comparisons Requested by the Subject

#### Virtual Machines vs Docker

A virtual machine runs a full operating system. Docker containers are lighter and faster to start. For this project, Docker is a better fit because the goal is to run several services together in a simple way.

#### Secrets vs Environment Variables

Environment variables are easy to use in scripts, which is why this project uses `.env`. Docker secrets are safer for passwords and other sensitive data. In this project, environment variables were chosen because they are simpler to set up.

#### Docker Network vs Host Network

A Docker network lets containers communicate privately. Host network mode would make a container use the host network directly. In this project, a Docker network is used so the containers can talk to each other while only NGINX is accessible from outside.

#### Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and are useful for saving data. Bind mounts connect a specific folder from the host to a container. In this project, the data is saved in folders inside `/home/efittant/data/...` so the WordPress files and database stay on the host machine.

## Instructions

### Prerequisites

- Docker Engine
- Docker Compose plugin (`docker compose`)
- `make`
- A host entry resolving `efittant.42.fr` to the local machine
- The host directories used by the volumes

### Required Configuration

1. Add `.env` to the repository.
2. Make sure the volume directories exist on the host:
   - `/home/efittant/data/wordpress`
   - `/home/efittant/data/mariadb`
3. Add the domain to `/etc/hosts` if it is not already there:

127.0.0.1 efittant.42.fr


### Build And Run

From the repository root:

make build
make up

Available Make targets:

- `make build`: build the three images
- `make up`: start the Compose stack
- `make stop`: stop running containers
- `make down`: stop the stack and remove containers and volumes declared by Compose

After startup, open:

https://efittant.42.fr

Because the certificate is self-signed, the browser will show a warning. That is normal for this project.

## Resources

### References

- Docker documentation: https://docs.docker.com/
- Docker Compose file reference: https://docs.docker.com/reference/compose-file/
- NGINX documentation: https://nginx.org/en/docs/
- MariaDB documentation: https://mariadb.com/kb/en/documentation/
- WordPress documentation: https://wordpress.org/documentation/
- WP-CLI documentation: https://developer.wordpress.org/cli/commands/
- OpenSSL `req` command reference: https://docs.openssl.org/

### AI Usage

AI was used to help produce the Markdown documentation required by chapters VI and VII of the subject, as well as for brainstorming and understanding of basics concepts.

