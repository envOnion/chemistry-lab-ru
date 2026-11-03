FROM nginx:stable-alpine@sha256:0e52bd054126cdc040b1276c0af347aeb02a41b9cfe305d6094767ac30e97949

ENV NGINX_ENTRYPOINT_WORKER_PROCESSES_AUTOTUNE=1

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html catalog.json LICENSE THIRD_PARTY_NOTICES.md /usr/share/nginx/html/
COPY courses/*.html /usr/share/nginx/html/courses/
COPY covers/*.webp /usr/share/nginx/html/covers/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1
