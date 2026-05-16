FROM perl:5.40

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev build-essential cpanminus \
    && rm -rf /var/lib/apt/lists/*

COPY cpanfile ./
RUN cpanm --notest --installdeps .

COPY . .

EXPOSE 5000

CMD ["sh", "-lc", "./script/harpoon_api daemon -l http://*:${APPLICATION_PORT:-5000}"]
