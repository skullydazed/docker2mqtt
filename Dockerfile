FROM debian:stable
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Pre-reqs
RUN apt update && \
    apt install --no-install-recommends -y apt-transport-https ca-certificates curl gnupg gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt update && \
    apt install --no-install-recommends -y docker-ce-cli python3-paho-mqtt && \
    rm -rf /var/lib/apt/lists/*

# Copy files into place
COPY docker2mqtt /

# Pass correct stop signal to script
STOPSIGNAL SIGINT

# Set the entrypoint
ENTRYPOINT ["/docker2mqtt"]
