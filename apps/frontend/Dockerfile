FROM nginx:1.25-alpine
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
USER nginx
EXPOSE 80
HEALTHCHECK --interval=30s CMD wget -qO- http://localhost/health || exit 1
