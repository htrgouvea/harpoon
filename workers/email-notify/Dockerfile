FROM debian:latest
MAINTAINER Nozaki Labs <contact@nozaki.io>

COPY . /usr/src/email-notify
WORKDIR /usr/src/email-notify

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

RUN cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom

# perl app.pl