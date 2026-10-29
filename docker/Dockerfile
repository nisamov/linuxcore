FROM alpine:3.20 AS fetch
RUN apk update && apk upgrade --no-cache && \
    apk add --no-cache wget curl
WORKDIR /site

RUN wget --mirror --convert-links --adjust-extension --page-requisites \
        --no-parent --no-host-directories -P /site https://linuxcore.site/ || true; \
    test -s /site/index.html

RUN set -eu; mkdir -p /site/db; \
    for f in commands.json distros.json; do \
      curl -fsSL -o "/site/db/$f" \
        "https://github.com/nisamov/linuxcore/releases/latest/download/$f"; \
      test -s "/site/db/$f"; \
    done

FROM nginx:alpine
RUN apk update && apk upgrade --no-cache
LABEL org.opencontainers.image.source="https://github.com/nisamov/linuxcore" \
      org.opencontainers.image.description="LinuxCore web en local con los datos de la última release" \
      org.opencontainers.image.licenses="MIT"
COPY --from=fetch /site /usr/share/nginx/html
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
EXPOSE 80