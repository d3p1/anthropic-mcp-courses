##
# @description Docker image to run app
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        Install `uv` and `npm`
##
FROM python:3

RUN apt-get update && apt-get install -y sudo
RUN groupadd -r -g 1000 dev && useradd -r -u 1000 -g dev -m -s /bin/bash dev && \
    usermod -aG sudo dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

RUN sudo apt-get update && sudo apt-get install -y nodejs npm
RUN sudo curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /home/dev/app/src

COPY --chown=dev:dev src/ .

EXPOSE 6274
EXPOSE 6277

ENV UV_VENV_CLEAR=1
RUN /bin/bash -c "/home/dev/.local/bin/uv venv && source .venv/bin/activate && /home/dev/.local/bin/uv pip install -e .anthropic-mcp-courses-app-1"