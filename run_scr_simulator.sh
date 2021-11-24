#!/bin/bash
#
#
if [[ "$1" == "--version" ]]
then
docker-compose -f docker-compose_scr_simulator.yml run --rm tkw_scr_simulator $1
	exit 0
else
	if [[ "$1" == "-d" ]]
	then
	docker-compose -f docker-compose_scr_simulator.yml up -d
	else
		docker-compose -f docker-compose_scr_simulator.yml up
	fi
fi
