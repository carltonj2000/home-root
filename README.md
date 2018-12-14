# Home And Digital Ocean Web Setup

The diagram of the setup can be found
[here](https://docs.google.com/drawings/d/13VyCrZbnPymv7wfnjO2jlD06-W2CV74MiILdoC--vvk/edit?usp=sharing).

Read the [digital ocean issues](#-Digital-Ocean-Issues) section.

# Commands

The commands below should be in the makefile if it has been update.

docker-compose -f docker-compose-home.yml build
docker-compose -f docker-compose-home.yml up

# Home https

The instruction below were adapted from the
[HTTPS on localhost with NGINX](https://imagineer.in/blog/https-on-localhost-with-nginx/)
article.

- generate and SSL self signed certificate with the following command.
  `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt`
- enter the following information at the prompts

```
Country Name (2 letter code) []:US
State or Province Name (full name) []:Nevada
Locality Name (eg, city) []:Las Vegas
Organization Name (eg, company) []:CJ Home
Organizational Unit Name (eg, section) []:Mac
Common Name (eg, fully qualified host name) []:*.home.com
Email Address []:carlton.joseph@gmail.com
```

- view the details of the cert via
  `openssl x509 -text -noout -in localhost.crt`
- Safari and Chrome will use this cert via the keychain by entering the command
  below (note Firefox uses it on internal CA and warn about security)
  `sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.crt`

# Hosts

Added the following to `/etc/hosts`.

```
127.0.0.1       carltonjoseph.dev
127.0.0.1       carltonathome.dev
127.0.0.1       appsfortracking.dev
127.0.0.1       carltonwin8.dev
127.0.0.1       tinandcarlton.dev
```

# Digital Ocean Issues

The following issue was seen on Ubuntu 16.04 and Docker x.x but I did not
check to see if this issue existed on 18.04.1 and Docker y.y.

The directory structure will reflect the
[docker machine structure diagram](https://docs.google.com/drawings/d/13VyCrZbnPymv7wfnjO2jlD06-W2CV74MiILdoC--vvk/edit?usp=sharing).
On a digitalocean server the docker daemon failed to auto start the docker
containers on boot when a mounted drive was used. I am guessing because the
mounted drive was not settled down when the docker demon tried to start the
containers. The solution was to start the docker containers from a non mounted
drive and map the mounted drives that contain the bulk data not stored in the
repos (builds, rsync, etc). A mounted drive is used because moving the setup to
a new machine is easier with a mounted drive and there is more space on a
mounted drive vs the host non mounted drive. With this setup there was no issue
on auto starting the container on the system boot. The same setup will be
duplicated on my local machine in order to have a consistent set up between my
local and hosted machines.
