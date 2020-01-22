FROM debian:latest
MAINTAINER Nozaki Labs <contact@nozaki.io>

COPY . /usr/src/pastebin
WORKDIR /usr/src/pastebin

RUN apt -qy update \
    && apt list --upgradable \
    && apt -qy upgrade \
    && apt install -qy curl \
                    make \
                    perl \
                    libwww-perl \
                    libdbd-mysql-perl \
    && apt clean \
  	&& apt -y autoremove

RUN cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom
     
CMD perl app.pl