FROM debian:trixie-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    python-is-python3 python3-pip python3-venv \
    rocm-cmake rocm-device-libs rocm-smi rocminfo \
    librccl1 libamdhip64-dev

RUN python -m venv /root/.uruha_python
RUN /root/.uruha_python/bin/pip install ipython

RUN mkdir -p /root/place
WORKDIR /root/place

CMD ["/root/.uruha_python/bin/ipython"]
