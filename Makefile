container:
	@echo "===================================================================="
	@echo "Build production ready docker container"
	@echo "===================================================================="
	@docker build --tag code/code:prod --tag code/code:latest .

prod: container
	@echo "===================================================================="
	@echo "Start and enter production ready docker container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it code/code:prod /bin/bash

base-container:
	@echo "===================================================================="
	@echo "Build Docker Container"
	@echo "===================================================================="
	@docker build --target base --tag ucyo/geomatch:base .

bash: base-container
	@echo "===================================================================="
	@echo "Start and enter container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it \
			--volume $(shell pwd)/code:/home/python/code \
			--workdir /home/python/code \
			ucyo/geomatch:base \
			/bin/bash

.PHONY: bash base-container container prod
