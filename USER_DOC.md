# User Documentation

## What This Stack Provides

This project runs three services:

- `nginx`: the public web server, reachable from the host on HTTPS port `443`
- `wordpress`: the container that runs the WordPress site
- `mariadb`: the database used by WordPress

For the user, the result is a WordPress website in the browser and a WordPress admin panel.

## Start And Stop The Project

Run all commands from the root of the repository.

To build the images:

make build

To start the project:

make up

To stop the running containers without removing them:

make stop

To stop the project and remove the containers and volumes:

make down

## Access The Website And Admin Panel

The domain is set in [`srcs/.env`](/home/el/42/projects/inception/srcs/.env) with the `DOMAIN_NAME` variable. In this project it is:

efittant.42.fr

Open the public website at:

https://efittant.42.fr

Open the WordPress administration panel at:

https://efittant.42.fr/wp-admin

The NGINX container uses a self-signed certificate, so your browser will probably show a security warning the first time. That is normal here.

## Locate And Manage Credentials

The project credentials need to be added by the user and stored in [`srcs/.env`].

Important variables are:

- `DB_ROOT_PASS`: MariaDB root password
- `DB_NAME`: WordPress database name
- `DB_USER`: database user for WordPress
- `DB_PASSWORD`: password for `DB_USER`
- `WP_ADMIN`: WordPress administrator username
- `WP_ADMIN_PASSWORD`: WordPress administrator password
- `WP_ADMIN_EMAIL`: WordPress administrator email
- `WP_USER`: second WordPress user created at startup
- `WP_USER_PASSWORD`: password for the second user
- `WP_USER_EMAIL`: email for the second user


## Check That The Services Are Running Correctly

Use Docker Compose to check the stack:

docker compose -f srcs/docker-compose.yml ps

You should see these three services:

- `nginx`
- `wordpress`
- `mariadb`

To see the logs:

docker compose -f srcs/docker-compose.yml logs

To see the logs of one service only:

docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb

Simple checks:

- Visit `https://efittant.42.fr` and check that the WordPress site opens.
- Visit `https://efittant.42.fr/wp-admin` and check that the login page opens.
- Confirm `docker compose -f srcs/docker-compose.yml ps` shows all three containers as running.

If the site does not open, first check:

- the domain resolution in `/etc/hosts`
- whether port `443` is already in use on the host
- whether the host paths for persistent data exist
- the logs of `nginx`, `wordpress`, and `mariadb`
