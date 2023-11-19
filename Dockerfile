FROM debian:trixie-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    python-is-python3 python3-pip python3-venv pipx \
    rocm-cmake rocm-device-libs rocm-smi rocminfo \
    librccl1 libamdhip64-dev

RUN python3 -m pipx ensurepath
RUN pipx install ipython

WORKDIR /root

CMD ["/usr/bin/env ipython"]
