
bash:
	@echo "===================================================================="
	@echo "Start and enter container"
	@echo "===================================================================="
	@docker run --rm -it -v $(shell pwd):/home/python/imktk imktk/imktk bash
