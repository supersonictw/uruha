FROM ubuntu:focal

RUN mkdir --parents --mode=0755 /etc/apt/keyrings
RUN wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg

RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/debian focal main" | tee /etc/apt/sources.list.d/rocm.list
RUN echo -e 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' | tee /etc/apt/preferences.d/rocm-pin-600

RUN apt-get update
RUN apt-get install rocm-hip-libraries

RUN python -m venv /root/.uruha_python
RUN /root/.uruha_python/bin/pip install ipython

RUN mkdir -p /root/place
WORKDIR /root/place

CMD ["sh", "-c", ". /root/.uruha_python/bin/activate && ipython"]
