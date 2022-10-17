FROM ubuntu:latest

ENV SIAB_USERCSS="Normal:-/etc/shellinabox/options-enabled/00+Black-on-White.css,Reverse:+/etc/shellinabox/options-enabled/00_White-On-Black.css;Colors:+/etc/shellinabox/options-enabled/01+Color-Terminal.css,Monochrome:-/etc/shellinabox/options-enabled/01_Monochrome.css" \
    SIAB_PORT=4200 \
    SIAB_ADDUSER=true \
    SIAB_USER=guest \
    SIAB_USERID=1000 \
    SIAB_GROUP=guest \
    SIAB_GROUPID=1000 \
    SIAB_PASSWORD=putsafepasswordhere \
    SIAB_SHELL=/bin/host_shell \
    SIAB_HOME=/home/guest \
    SIAB_SUDO=true \
    SIAB_SSL=false \
    SIAB_SERVICE=/:LOGIN \
    SIAB_PKGS=none \
    SIAB_SCRIPT=none \
    SIAB_SSH_COMMAND=none

RUN apt-get update && apt-get install -y openssl curl openssh-client sudo shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    ln -sf '/etc/shellinabox/options-enabled/00+Black on White.css' \
      /etc/shellinabox/options-enabled/00+Black-on-White.css && \
    ln -sf '/etc/shellinabox/options-enabled/00_White On Black.css' \
      /etc/shellinabox/options-enabled/00_White-On-Black.css && \
    ln -sf '/etc/shellinabox/options-enabled/01+Color Terminal.css' \
      /etc/shellinabox/options-enabled/01+Color-Terminal.css

RUN rm -f /etc/update-motd.d/*

EXPOSE 4200

ADD assets/host_shell.sh /bin/host_shell
ADD assets/entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["shellinabox"]
