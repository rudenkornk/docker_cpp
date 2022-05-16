FROM rudenkornk/docker_ci:1.0.0

# First, ask system administrator to install necessary packages
USER root
WORKDIR /root

COPY install_gcc.sh ./
RUN ./install_gcc.sh

COPY install_boost.sh ./
RUN ./install_boost.sh

# llvm goes after boost, because it is expected that it will be changed more frequently than boost
COPY install_llvm.sh ./
RUN ./install_llvm.sh

COPY install_cmake.sh ./
RUN ./install_cmake.sh

COPY config_system.sh ./
RUN ./config_system.sh

COPY --chown=ci_user \
  license.md \
  readme.md \
  /home/ci_user/

WORKDIR /home/repo

# See https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.authors="Nikita Rudenko"
LABEL org.opencontainers.image.vendor="Nikita Rudenko"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Docker image for C++ CI"
LABEL org.opencontainers.image.base.name="rudenkornk/docker_ci:1.0.0"

ARG IMAGE_NAME
LABEL org.opencontainers.image.ref.name="${IMAGE_NAME}"
LABEL org.opencontainers.image.url="https://hub.docker.com/repository/docker/${IMAGE_NAME}"
LABEL org.opencontainers.image.source="https://github.com/${IMAGE_NAME}"

ARG VERSION
LABEL org.opencontainers.image.version="${VERSION}"

ARG VCS_REF
LABEL org.opencontainers.image.revision="${VCS_REF}"

ARG BUILD_DATE
LABEL org.opencontainers.image.created="${BUILD_DATE}"
