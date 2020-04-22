FROM debian:latest
MAINTAINER Heitor Gouvêa <hi@heitorgouvea.me>

COPY . /usr/src/pastebin
WORKDIR /usr/src/pastebin

RUN apt -qy update \
    && apt list --upgradable \
    && apt -qy upgrade \
    && apt install -qy curl \
                      make \
                      gcc \
                      perl \
                      cron \
                      libwww-perl \
                      libdbd-mysql-perl \
    && apt clean \
  	&& apt -y autoremove

RUN cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom

# RUN (crontab -l 2>/dev/null; echo "* * * * * perl /usr/src/pastebin/app.pl") | crontab -
# RUN (crontab -l ; echo "* * * * * perl /usr/src/pastebin/app.pl >> /var/log/pastebin.log") | crontab