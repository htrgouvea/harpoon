FROM debian:latest
MAINTAINER Heitor Gouvêa <hi@heitorgouvea.me>

COPY . /usr/src/slack-notify
COPY /env/cronjobs /etc/cron.d/cronjobs

WORKDIR /usr/src/slack-notify

RUN apt -qy update \
    && apt list --upgradable \
    && apt -qy upgrade \
    && apt install -qy curl \
                    make \
                    gcc \
                    cron \
                    perl \
                    libwww-perl \
                    libdbd-mysql-perl \
    && apt clean \
  	&& apt -y autoremove

RUN cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom Email::MIME Email::Sender::Simple Email::Sender::Transport::SMTP
RUN crontab /etc/cron.d/cronjobs

CMD ["cron", "-f"]