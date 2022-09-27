ifeq ($(OS),Windows_NT)
	COPY = copy
	SEP  = \\
else
	COPY = cp
	SEP  = /
	UID = $$(id -u)
    GID = $$(id -g)
endif

.PHONY: setup
setup:
	@$(COPY) .env.example .env
	@sed -i "s/{UID}/$(UID)/" .env
	@sed -i "s/{GID}/$(GID)/" .env
	@sed -i "s/<UID>/$(UID)/" Dockerfile
	@sed -i "s/<GID>/$(GID)/" Dockerfile
	@mkdir wordpress
build:
	docker-compose up -d --build
run:
	docker-compose up -d