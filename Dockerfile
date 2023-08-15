FROM python:3-slim as dev

ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/home/python/.rye/shims:$PATH" \
    PIP_NO_CACHE_DIR="false" \
    RYE_VERSION="0.11.0" \
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

COPY --chown=python:python ./code /home/python/code
WORKDIR /home/python/code

RUN rye config --set-bool behavior.global-python=true && \
    rye sync && \
    rye build --wheel

CMD ["rye", "run", "python"]

FROM python:3-slim as prod
COPY --from=dev /home/python/code/dist /dist
RUN pip install /dist/*.whl
