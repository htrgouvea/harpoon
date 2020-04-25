#!/usr/env bash

docker build --rm --squash -t uranus-database ./database/
docker run -d -p 3306:3306 --name database -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

docker build --rm --squash -t bing-crawler ./crawlers/bing/
docker build --rm --squash -t email-notify ./workers/email-notify

docker run -d --name bing bing-crawler
docker run -d --name email-notify  email-notify