FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

# Repositori custom propi
ADD http://master.debci.antonialoytorrens.com/key.gpg \
	/etc/apt/keyrings/master.debci.antonialoytorrens.com.gpg
RUN chmod 644 /etc/apt/keyrings/master.debci.antonialoytorrens.com.gpg \
	&& printf 'deb [signed-by=/etc/apt/keyrings/master.debci.antonialoytorrens.com.gpg] http://master.debci.antonialoytorrens.com/debian trixie main\n' \
		> /etc/apt/sources.list.d/master.debci.antonialoytorrens.com.list \
	&& apt-get update \
	&& apt-get install -yq --no-install-recommends \
	ca-certificates \
	git \
	make \
	curl \
	jq \
	unzip \
	shellcheck \
	# Repositori custom
	sonar-scanner \
	&& update-ca-certificates \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* \
	# Usuari
	&& useradd --create-home --shell /bin/bash builder \
	&& mkdir -p /workspace \
	&& chown builder:builder /workspace

USER builder
WORKDIR /workspace
CMD ["bash"]
