FROM ubuntu:22.10

ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/home/python/.poetry/bin:/home/python/.local/bin:$PATH" \
    PIP_NO_CACHE_DIR="false" \
    POETRY_VERSION="1.5.1"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    inotify-tools \
    make \
    python-is-python3 \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 python && \
    useradd  --uid 1000 --gid python --shell /bin/bash --create-home python

USER 1000
RUN mkdir /home/python/app
WORKDIR /home/python/app

RUN curl -sSL https://install.python-poetry.org | python3 -

COPY --chown=python:python . /home/python

RUN poetry install --no-interaction --no-ansi

CMD ["ls"]
