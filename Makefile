container:
	@echo "===================================================================="
	@echo "Build Docker Container"
	@echo "===================================================================="
	@docker build --target dev --tag code/code:dev .

bash: container
	@echo "===================================================================="
	@echo "Start and enter container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it -v $(shell pwd)/code:/home/python/code --workdir /home/python/code code/code:dev /bin/bash

release-container:
	@echo "===================================================================="
	@echo "Build Docker Container"
	@echo "===================================================================="
	@docker build --tag code/code:prod .

release-bash: release-container
	@echo "===================================================================="
	@echo "Start and enter container"
	@echo "===================================================================="
	@docker run --env-file=.env --rm -it code/code:prod /bin/bash
.PHONY: bash container release-bash release-container
