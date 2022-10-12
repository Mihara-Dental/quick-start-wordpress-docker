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

increase-uploadFile:
	echo "php_value upload_max_filesize 64M" >> wordpress/.htaccess
	echo "php_value post_max_size 128M" >> wordpress/.htaccess
	echo "php_value memory_limit 256M" >> wordpress/.htaccess
	echo "php_value max_execution_time 300" >> wordpress/.htaccess
	echo "php_value max_input_time 300" >> wordpress/.htaccess

build:
	docker-compose up -d --build
	make increase-uploadFile
run:
	docker-compose up -d