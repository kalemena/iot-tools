FROM alpine:3.15 as builder

RUN \
# Pre-requisits
  apk add --no-cache \
    gcc \
    musl-dev \
    git \
    make \
    gfortran \
# Build and Install
  && cd / \
  && git clone --depth=1 https://github.com/rtklibexplorer/RTKLIB.git \
  && cd RTKLIB/app/consapp \
  && make CC=gcc \
  && make install

FROM alpine:3.15

COPY --from=builder ["/usr/local/bin/*", "/usr/local/bin/"]

EXPOSE 6000

STOPSIGNAL SIGTERM

COPY [ "entrypoint.sh", "/entrypoint.sh" ]

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD []