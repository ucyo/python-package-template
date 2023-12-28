FROM python:3-slim as rye

ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/home/python/.local/bin:/home/python/.rye/shims:$PATH" \
    PIP_NO_CACHE_DIR="false"

ENV RYE_VERSION="0.16.0" \
    RYE_INSTALL_OPTION="--yes"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    inotify-tools \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 python && \
    useradd  --uid 1000 --gid python --shell /bin/bash --create-home python

USER 1000
WORKDIR /home/python/

RUN curl -sSf https://rye-up.com/get | bash -

COPY --chown=python:python ./app/pyproject.toml ./app/README.md ./app/requirements-dev.lock ./app/requirements.lock /home/python/app/
WORKDIR /home/python/app

FROM rye as dev

RUN rye config --set-bool behavior.global-python=true && \
    rye sync

FROM dev as build
COPY --chown=python:python ./app /home/python/app/
WORKDIR /home/python/app
RUN mkdir dist && rye build --wheel --clean

FROM python:3-slim as prod
COPY --from=build /home/python/app/dist /dist
RUN pip install /dist/*.whl
CMD ["rye", "run", "python"]
