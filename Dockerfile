FROM debian:bookworm-slim

ADD build /build

WORKDIR /build
RUN bash dpkg.sh
RUN bash rocm.sh
RUN bash ipython.sh

#RUN rm -rf /build

WORKDIR /root
CMD ["/usr/local/bin/ipython"]
