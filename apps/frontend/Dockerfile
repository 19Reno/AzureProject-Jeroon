FROM nginx:1.25-alpine
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
RUN chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d && \
    chmod -R 755 /var/cache/nginx
USER nginx
EXPOSE 8080
HEALTHCHECK --interval=30s CMD wget -qO- http://localhost:8080/health || exit 1
