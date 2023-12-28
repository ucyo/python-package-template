container:
	@echo "===================================================================="
	@echo "Build production ready docker container"
	@echo "===================================================================="
	@docker build --tag template/app:prod --tag template/app:latest .

prod: container
	@echo "===================================================================="
	@echo "Start and enter production ready docker container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it template/app:prod /bin/bash

dev-container:
	@echo "===================================================================="
	@echo "Build Development Container"
	@echo "===================================================================="
	@docker build --target dev --tag template/app:dev .

bash: dev-container
	@echo "===================================================================="
	@echo "Start and enter development container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it \
			--volume $(shell pwd)/code:/home/python/code \
			--workdir /home/python/code \
			 template/app:dev \
			/bin/bash

.PHONY: bash dev-container container prod
