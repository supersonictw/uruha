FROM ubuntu:focal

RUN apt-get update
RUN apt-get install -y --no-install-recommends ca-certificates wget gpg

RUN mkdir --parents --mode=0755 /etc/apt/keyrings
RUN wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg > /dev/null

RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/debian focal main" | tee /etc/apt/sources.list.d/rocm.list
RUN echo "Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600" | tee /etc/apt/preferences.d/rocm-pin-600

RUN apt-get update
RUN apt-get install -y --no-install-recommends rocm-hip-libraries python3 python3-pip python3-venv python-is-python3

RUN python -m venv /root/.uruha_python
RUN /root/.uruha_python/bin/pip install ipython

RUN mkdir -p /root/place
WORKDIR /root/place

CMD ["sh", "-c", ". /root/.uruha_python/bin/activate && ipython"]
