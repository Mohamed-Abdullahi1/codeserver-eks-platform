FROM debian:bookworm-slim AS downloader

ARG CODE_SERVER_VERSION=4.113.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /usr/local/lib/code-server \
 && curl -fL "https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz" \
    | tar -xz --strip-components=1 -C /usr/local/lib/code-server


FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m coder

COPY --from=downloader /usr/local/lib/code-server /usr/local/lib/code-server

RUN ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server

USER coder

WORKDIR /home/coder

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]