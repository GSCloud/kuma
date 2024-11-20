#@author Fred Brooker <git@gscloud.cz>
include .env

run ?=
um_status != docker inspect --format '{{json .State.Running}}' ${KUMA_CONTAINER_NAME} 2>/dev/null | grep true

ifneq ($(strip $(um_status)),)
umdot=🟢
else
umdot=🔴
endif

all: info

info:
	@echo "\n\e[1;32mUptime Kuma in Docker 👾\e[0m v1.0 2024-11-20\n"
	@echo "\e[0;1m📦️ Kuma\e[0m \t $(umdot) \e[0;4m${KUMA_CONTAINER_NAME}\e[0m \t🚀 http://localhost:${KUMA_PORT}"
	@echo ""

	@echo " - \e[0;1m install\e[0m - install containers"
	@echo " - \e[0;1m start\e[0m - start containers"
	@echo " - \e[0;1m stop\e[0m - stop containers"
	@echo " - \e[0;1m test\e[0m - test containers"
	@echo " - \e[0;1m kill\e[0m - kill containers"
	@echo " - \e[0;1m remove\e[0m - remove containers"
	@echo " - \e[0;1m backup\e[0m - backup database"
	@echo " - \e[0;1m restore\e[0m - restore database"
	@echo " - \e[0;1m exec\e[0m - run shell inside container"
	@echo " - \e[0;1m exec run='<command>'\e[0m - run <command> inside container"
	@echo " - \e[0;1m debug\e[0m - install containers, run interactively"
	@echo " - \e[0;1m config\e[0m - display Docker compose configuration"
	@echo " - \e[0;1m logs\e[0m - display logs"
	@echo " - \e[0;1m purge\e[0m - delete persistent data ❗️"
	@echo " - \e[0;1m docs\e[0m - transpile documentation into PDF"
	@echo ""

docs:
	@echo "transpiling documentation ..."
	@bash ./bin/create_pdf.sh

debug:
	@docker compose up

install: remove
	@date
	@echo "installing containers ..."
	@docker compose up -d
	@echo "\n\e[0;1m📦️ Kuma\e[0m: 🚀 http://localhost:${KUMA_PORT}\n"
	@date
	@echo ""

start:
	@echo "starting containers ..."
	@docker start ${KUMA_CONTAINER_NAME}

stop:
	@echo "stopping containers ..."
	@-docker stop ${KUMA_CONTAINER_NAME}

kill:
	@echo "😵"
	@docker compose kill

remove:
	@echo "removing containers ..."
	@-docker rm ${KUMA_CONTAINER_NAME} --force 2>/dev/null

config:
	@docker compose config

exec:
ifneq ($(strip $(run)),)
	@docker exec ${KUMA_CONTAINER_NAME} $(run)
else
	@docker exec -it ${KUMA_CONTAINER_NAME} sh
endif

logs:
	@docker logs -f ${KUMA_CONTAINER_NAME}

backup:
ifneq ($(shell id -u),0)
	@echo "root permission required"
	@sudo echo ""
endif
	@date
	@docker compose down
	@rm -rf bak
	@mkdir bak
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo tar czf bak/kuma-data.tgz kuma-data
	@cp Makefile bak/
	@cp .env bak/
	@cp docker-compose.yml bak/
	@-make install
	@date

restore: remove
ifneq ($(shell id -u),0)
	@echo "root permission required"
	@sudo echo ""
endif
	@date
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo rm -rf kuma-data
ifneq ($(wildcard ./bak/.),)
	@echo "backup location: bak"
ifneq ($(wildcard bak/kuma-data.tgz),)
	@-sudo tar xzf bak/kuma-data.tgz 2>/dev/null
else
	@echo "❗️ missing database archive"
	exit 1
endif
else
	@echo "backup location: ."
ifneq ($(wildcard kuma-data.tgz),)
	@-sudo tar xzf kuma-data.tgz 2>/dev/null
else
	@echo "❗️ missing database archive"
	exit 1
endif
endif
	@-make install
	@date

purge: remove
	@echo "💀 deleting permanent storage"
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	sudo rm -rf kuma-data

test:
ifneq ($(strip $(um_status)),)
	@echo "🟢 Kuma is up"
	@exit 0
else
	@echo "🔴 Kuma is down"
	@exit 255
endif
