# Lastest debian:wheezy
FROM debian:wheezy

MAINTAINER Patrik Hagedorn <p.hagedorn@visono.com>

USER root

# Set the locale
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM="xterm"

# Install curl, wget, unzip, htop, procps, vim, screen, supervisor, at, whois, less, python-pip, uuid-runtime
RUN apt-get update -q \
&& apt-get install -y \
    curl \
    wget \
    unzip \
    htop \
    procps \
    vim \
    screen \
    supervisor \
    at \
    whois \
    less \
    python-pip \
    uuid-runtime \
&& chmod 777 /var/run/screen \
&& mkdir -p /var/log/supervisor \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& pip install supervisor --upgrade

# Install security updates and patches
RUN apt-get update -q \
&& apt-get upgrade -y \
&& apt-get dist-upgrade -y \
&& apt-get autoclean -y \
&& apt-get autoremove -y

# Adding history search with page up and page down
RUN sed -i'' 's|# "\\e\[5~": history-search-backward|"\\e\[5~": history-search-backward|' /etc/inputrc \
&& sed -i'' 's|# "\\e\[6~": history-search-forward|"\\e\[6~": history-search-forward|' /etc/inputrc

# Adding limits module to pam config
RUN echo "session required pam_limits.so" >> /etc/pam.d/common-session \
&& echo "session required pam_limits.so" >> /etc/pam.d/common-session-noninteractive

# Adding limits.conf
COPY limits.conf /etc/security/limits.conf

# Adding supervisord.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf

# Adding scripts
COPY run.sh /run.sh
RUN chmod 755 /*.sh

CMD ["/bin/bash"]