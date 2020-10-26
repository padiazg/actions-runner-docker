FROM debian:buster-slim

ARG GITHUB_RUNNER_VERSION="2.273.5"

ENV RUNNER_NAME "runner"
ENV GITHUB_PAT ""
ENV GITHUB_OWNER ""
ENV GITHUB_REPOSITORY ""
ENV RUNNER_WORKDIR "_work"
ENV RUNNER_LABELS ""

RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        git \
        jq \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    # Install Docker CLI
    && curl -fsSL https://get.docker.com -o- | sh && \
        rm -rf /var/lib/apt/lists/* && \
        apt-get clean \
    # Install Docker-Compose
    && curl -L -o /usr/local/bin/docker-compose \
        "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" && \
        chmod +x /usr/local/bin/docker-compose \
    && useradd -m github \
    && usermod -aG sudo github \
    && usermod -aG docker github \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

USER github
WORKDIR /home/github

RUN curl -Ls https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz | tar xz \
    && sudo ./bin/installdependencies.sh

COPY --chown=github:github entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]