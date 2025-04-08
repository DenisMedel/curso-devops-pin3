##### Etapa de despliegue #####
###############################
FROM nginx:1.27 AS deploy-stage
ENV TZ=America/Argentina/Cordoba
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /usr/share/nginx/html

# Define usuario y grupo
ARG APP_UID=14000
ARG APP_USER=nginxuser

RUN groupadd --gid ${APP_UID} ${APP_USER} && \
    useradd --system --uid ${APP_UID} --gid ${APP_UID} ${APP_USER}

# Configura permisos
RUN mkdir -p /var/run/nginx /var/cache/nginx && \
    chown -R ${APP_USER}:${APP_USER} /var/run/nginx /var/cache/nginx /etc/nginx && \
    chmod -R 755 /var/run/nginx /var/cache/nginx && \
    touch /var/run/nginx.pid && \
    chown ${APP_USER}:${APP_USER} /var/run/nginx.pid

# Copia aplicación y config de Nginx
#COPY --from=build-stage /app/dist/app/browser app/
COPY nginx-custom.conf /etc/nginx/conf.d/default.conf

# Permisos para nginx
RUN chown -R ${APP_USER}:${APP_USER} /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html 

# Asigna usuario no root
USER ${APP_USER}

EXPOSE 80
