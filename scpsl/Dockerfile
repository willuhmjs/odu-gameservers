FROM steamcmd/steamcmd AS steam

WORKDIR /scpsl
RUN steamcmd +force_install_dir /scpsl \
    +login anonymous \
    +app_update 996560 validate \
    +quit

FROM ubuntu:20.04

ARG UID=999
ARG GID=999

USER root
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y ca-certificates gnupg && \
    gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get install -y mono-complete

RUN groupadd -g $GID scpsl && \
    useradd -m -s /bin/false -u $UID -g scpsl scpsl && \
    mkdir -p /scpsl /config "/home/scpsl/.config/SCP Secret Laboratory/config" && \
    ln -s /config "/home/scpsl/.config/SCP Secret Laboratory/config/7777" && \
    chown -R scpsl:scpsl /scpsl /config /home/scpsl

COPY --chown=scpsl:scpsl --from=steam /scpsl /scpsl
COPY --chown=scpsl:scpsl ["localadmin_internal_data.json", "/home/scpsl/.config/SCP Secret Laboratory/config/"]

VOLUME /config
EXPOSE 7777/tcp
EXPOSE 7777/udp

USER scpsl
WORKDIR /scpsl
ENTRYPOINT ["/scpsl/LocalAdmin", "7777"]