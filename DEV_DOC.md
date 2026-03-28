# Developer Documentation

## Environment Setup From Scratch

### Prerequisites

- Docker Engine
- Docker Compose plugin
- `make`
- permission to write to the persistent data folders used by the project

### Repository Layout

- [`Makefile`]: shortcuts for build and lifecycle commands
- [`srcs/docker-compose.yml`]: service orchestration
- [`srcs/.env`]: runtime configuration and credentials
- [`srcs/requirements/nginx/`]: NGINX image and configuration
- [`srcs/requirements/wordpress/`]: WordPress and PHP-FPM image and bootstrap script
- [`srcs/requirements/mariadb/`]: MariaDB image, configuration, and bootstrap script

### Configuration Files

Before the first launch, review:

- [`srcs/.env`] for database and WordPress values
- [`srcs/docker-compose.yml`] for services and host data paths
- [`srcs/requirements/nginx/conf/nginx.conf`] for TLS and PHP forwarding
- [`srcs/requirements/mariadb/conf/50-server.cnf`] for MariaDB server options

### Secrets

The subject mentions secrets, but this project does not currently use Docker secrets in Compose. The credentials are stored in [`srcs/.env`](needs to be mainually added to the repository by the user, as it contains sensitive data), and the `secrets/` folder is not used at the moment.

### Host Preparation

The Compose file uses these host paths for persistent data:

- `/home/efittant/data/wordpress`
- `/home/efittant/data/mariadb`

Create those directories before the first launch, or change the paths in [`srcs/docker-compose.yml`] to match your local setup.

You also need the local domain to point to your machine:

127.0.0.1 efittant.42.fr

## Build And Launch

The main commands are the Makefile targets:

make build
make up


Other available targets:

make stop
make down

Useful Docker Compose commands:

docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
docker compose -f srcs/docker-compose.yml up --build
docker compose -f srcs/docker-compose.yml down -v

Useful container commands:

docker exec -it nginx bash
docker exec -it wordpress bash
docker exec -it mariadb bash

To inspect MariaDB inside the container:

mysql -u root -p
SHOW DATABASES;
SELECT User, Host FROM mysql.user;

## Container And Volume Management

How the services are connected:

- `nginx` depends on `wordpress`
- `wordpress` depends on `mariadb`
- all three services use the `inception` Docker network
- only `nginx` publishes a host port, `443:443`

Where the data is mounted:

- the `wordpress` volume is mounted into `/var/www/html`
- the `mariadb` volume is mounted into `/var/lib/mysql`
- both volumes are declared in Compose and point to host directories

This means rebuilding the containers does not remove the site data by itself. The WordPress files and MariaDB data stay on the host unless you delete them yourself.

## Where Data Is Stored

Current persistence locations:

- WordPress files: `/home/efittant/data/wordpress`
- MariaDB data: `/home/efittant/data/mariadb`

Behavior linked to persistence:

- the WordPress startup script downloads WordPress into `/var/www/html` only if the files are not already there
- the MariaDB startup script creates the database and user only if the database folder is not already initialized
