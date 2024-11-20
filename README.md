# Uptime Kuma in Docker v1.0 2024-11-20

## Uptime Kuma is an easy-to-use self-hosted monitoring tool

Kuma site: [https://uptime.kuma.pet](https://uptime.kuma.pet)  
Kuma repository: [https://github.com/louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)  
Kuma in Docker repository: [https://github.com/GSCloud/kuma](https://github.com/GSCloud/kuma)

## Usage

Run `make`:

- install - install containers
- start - start containers
- stop - stop containers
- test - test containers
- kill - kill containers
- remove - remove containers
- backup - backup database
- restore - restore database
- exec - run shell inside container
- exec run='\<command\>' - run \<command\> inside container
- debug - install containers, run interactively
- config - display Docker compose configuration
- logs - display logs
- purge - delete persistent data ❗️
- docs - transpile documentation into PDF

URL: [http://localhost:3001](http://localhost:3001)  

Copy `.env-dist` to `.env` and modify the file according to your needs.

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test functionality
- `make purge restore` - purge everything and restore from backup
- `make logs` - show logs from the main container
- `make test` - test containers (reinstall if it failes)

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz](https://gscloud.cz)
