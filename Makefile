TPL_PATH="${PWD}/templates"

.PHONY: update
update:
	if ! test -f ./bin/liveboat ; \
	then \
		mkdir -p ./bin; \
		wget -O ./bin/liveboat https://github.com/exaroth/liveboat/releases/download/stable/liveboat-linux-musl; \
		chmod +x ./bin/liveboat; \
	fi;
	LIVEBOAT_TEMPLATE_DIR="$(TPL_PATH)" ./bin/liveboat -x update --config-file=./config/liveboat-config.toml

# --- SonarQube ---
ifneq (,$(wildcard ./.env))
include .env
export
endif

.PHONY: sonarqube
sonarqube:
	sonar-scanner \
		-Dsonar.token=$(SONAR_TOKEN) \
		-Dsonar.host.url=$(SONAR_HOST_URL) \
		-Dsonar.projectKey=$(SONAR_PROJECT_KEY)
