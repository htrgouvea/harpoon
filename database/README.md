# Pastebin Crawler Database


```bash
    # building image
    $ docker build --rm --squash -t pastebin-database .

    # starting container
    $ docker run -d -p 3306:3306 --name maria -e MARIADB_ROOT_PASSWORD=mypassword pastebin-database

    # stop container
    $ docker stop pastebin-database

    # remove container
    $ docker rm pastebin-database
```