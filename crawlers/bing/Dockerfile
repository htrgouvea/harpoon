FROM debian:latest
MAINTAINER Heitor Gouvêa <hi@heitorgouvea.me>

COPY . /usr/src/bing
COPY /env/cronjobs /etc/cron.d/cronjobs

WORKDIR /usr/src/bing

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

RUN cpan install Config::Simple WWW::Mechanize DBIx::Custom
RUN crontab /etc/cron.d/cronjobs

CMD ["cron", "-f"]