FROM debian:latest
MAINTAINER Heitor Gouvêa <hi@heitorgouvea.me>

COPY . /usr/src/report-generator
WORKDIR /usr/src/report-generator

RUN apt -qy update \
    && apt list --upgradable \
    && apt -qy upgrade \
    && apt install -qy curl \
                    make \
                    gcc \
                    perl \
                    libwww-perl \
                    libdbd-mysql-perl \
    && apt clean \
  	&& apt -y autoremove

RUN cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom Email::MIME Email::Sender::Simple

# perl app.pl