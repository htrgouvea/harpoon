FROM        perl:latest
MAINTAINER  Heitor Gouvêa <hi@heitorgouvea.me>

EXPOSE 80

WORKDIR /usr/src/app
COPY . /usr/src/app

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Mojolicious::Lite Mojo::Util Mojo::JSON Mojo::UserAgent IO::Socket::SSL

CMD ["perl", "app.pl", "daemon", "-m", "production", "-l", "http://*:80"]
