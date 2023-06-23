container:
	@echo "===================================================================="
	@echo "Build Docker Container"
	@echo "===================================================================="
	@docker build --tag app/app .

bash: container
	@echo "===================================================================="
	@echo "Start and enter container"
	@echo "===================================================================="
	@docker run --rm -it -v $(shell pwd)/app:/home/python/app app/app bash
