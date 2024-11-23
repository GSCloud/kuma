# Uptime Kuma in Docker v1.0 2024-11-20

## Uptime Kuma is an easy-to-use self-hosted monitoring tool

Kuma site: [https://uptime.kuma.pet](https://uptime.kuma.pet)  
Kuma repository: [https://github.com/louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)  
Kuma in Docker repository: [https://github.com/GSCloud/kuma](https://github.com/GSCloud/kuma)

## Usage

Run `make`:

- install - install container
- start - start container
- stop - stop container
- test - test container
- kill - kill container
- remove - remove container
- backup - backup database
- restore - restore database
- exec - run shell inside container
- exec run='\<command\>' - run \<command\> inside container
- debug - install container, run interactively
- config - display Docker compose configuration
- logs - display logs
- purge - delete persistent data ❗️
- docs - transpile documentation into PDF

URL: [http://localhost:3001](http://localhost:3001)  

Copy `.env-dist` to `.env` and modify the file according to your needs.

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test
- `make purge restore` - purge everything and restore from backup
- `make logs` - show logs
- `make test` - test container

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz](https://gscloud.cz)
