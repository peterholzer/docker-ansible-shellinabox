FROM centos:7

# ENV SIAB_USERCSS=",Reverse:-/etc/shellinabox/options-enabled/00_White-On-Black.css;"
ENV SIAB_USERCSS="Normal:+/usr/share/shellinabox/white-on-black.css,Colors:+/usr/share/shellinabox/color.css,Monochrome:-/usr/share/shellinabox/monochrome.css" \
    SIAB_PORT=4200 \
    SIAB_ADDUSER=true \
    SIAB_USER=guest \
    SIAB_USERID=1000 \
    SIAB_GROUP=guest \
    SIAB_GROUPID=1000 \
    SIAB_PASSWORD=putsafepasswordhere \
    SIAB_SHELL=/bin/bash \
    SIAB_HOME=/home/guest \
    SIAB_SUDO=false \
    SIAB_SSL=true \
    SIAB_SERVICE=/:LOGIN \
    SIAB_PKGS=none \
    SIAB_SCRIPT=none

RUN yum update -y \
 && yum install -y epel-release \
 && yum install -y openssl curl openssh-client sudo shellinabox \
    python-pip git tree nano mc \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN pip install --upgrade pip \
 && pip install ansible
 # && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# RUN ln -sf '/etc/shellinabox/options-enabled/00+Black on White.css' /etc/shellinabox/options-enabled/00+Black-on-White.css \
 # && ln -sf '/usr/share/shellinabox/white-on-black.css' /etc/shellinabox/options-enabled/00_White-On-Black.css \
 # && ln -sf '/etc/shellinabox/options-enabled/01+Color Terminal.css' /etc/shellinabox/options-enabled/01+Color-Terminal.css

RUN curl -fL https://getcli.jfrog.io | sh

EXPOSE 4200

VOLUME /etc/shellinabox
VOLUME /var/log/supervisor
VOLUME /home

ADD assets/entrypoint.sh /usr/local/sbin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["shellinabox"]
