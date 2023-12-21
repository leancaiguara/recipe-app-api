FROM python:3.9-alpine3.13

# Es buena practica poner quien mantiene la imagen
LABEL maintainer="leandro_12"

# Desactivamos el buffer por lo que la salida se muestra directo en consola nose guarda
ENV PYTHONUNBUFFERED 1

# Se copian en el container el archivo con nuestras dependencias requeridas
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
# Se copia la carpeta(paquete) app con todo lo que tiene en el container
COPY ./app /app
# Se ingresa a la carpeta app, y se marca como carpeta predeterminada donde se ejecutan los cmds
WORKDIR /app
# Se expone el puerto 8000 del container
EXPOSE 8000

ARG DEV=false

# Ejecuta los siguientes comandos
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
    build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = 'true' ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Esto es para agregar py/bin y busque ejecutables ahi
ENV PATH="/py/bin:$PATH"

USER django-user


