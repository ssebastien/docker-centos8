FROM centos:8

LABEL maintainer="Sébastien"
LABEL org.opencontainers.image.source="https://github.com/ssebastien/docker-centos8"

ENV container=docker

# Install systemd -- See https://hub.docker.com/_/centos/
WORKDIR /lib/systemd/system/sysinit.target.wants/
RUN (for i in *; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i"; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /

# Install dependencies.
RUN dnf -y install epel-release && \
    dnf -y install \
      openssh-server \
      python3-pip && \
    dnf clean all

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
