FROM nginx:1.25-alpine
RUN rm -rf /etc/nginx/conf.d/default.conf && \
    chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid
COPY nginx.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
USER nginx
EXPOSE 8080
HEALTHCHECK --interval=30s CMD wget -qO- http://localhost:8080/health || exit 1
