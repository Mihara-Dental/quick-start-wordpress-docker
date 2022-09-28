ifeq ($(OS),Windows_NT)
# Windows
	COPY = copy
	SEP  = \\
else
	COPY = cp
	SEP  = /
	UID = $$(id -u)
	GID = $$(id -g)
ifeq ($(shell uname),Linux)
# Linux
	SED_I = sed -i
else
	SED_I = sed -i ''
endif
endif

.PHONY: setup
setup:
	@$(COPY) .env.example .env
	@$(SED_I) "s/{UID}/$(UID)/" .env
	@$(SED_I)  "s/{GID}/$(GID)/" .env
	@$(SED_I)  "s/<UID>/$(UID)/" Dockerfile
	@$(SED_I)  "s/<GID>/$(GID)/" Dockerfile
	@mkdir wordpress
build:
	docker-compose up -d --build
run:
	docker-compose up -d