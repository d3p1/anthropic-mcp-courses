##
# @description Docker image to run app
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        Install `uv` and `npm`
##
FROM python:3

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y nodejs npm
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN groupadd -r -g 1000 dev && useradd -r -u 1000 -g dev -m -s /bin/bash dev
RUN chown -R dev:dev /usr/src/app
USER dev
