<p align="center">
  <h1 align="center">Pastebin Crawler by @NozakiLabs</h1>
  <p align="center">Crawler that searches for certain strings in the pastebin in real time</p>

  <p align="center">
    <a href="https://github.com/NozakiLabs/pastebin_crawler/blob/master/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/NozakiLabs/pastebin_crawler/releases">
      <img src="https://img.shields.io/badge/version-0.9-blue.svg">
    </a>
  </p>
</p>

---


### How it works
```
  Pastebin is a type of web application that allows users to upload snippets of text, usually source code examples, for public viewing. Thousands of pastes are published daily, the problem is that some of these pastes have sensitive, restricted or eve confidential information. Using a crawler we can automatically monitor the posting of these folders and thus check the content of each one of them with a regex of our choice.
```

### Download and setup:
```bash
  # Download
  $ git clone https://github.com/NozakiLabs/pastebin_crawler
  $ cd pastebin_crawler

  # Building MariaDB Database
  $ docker build --rm --squash -t pastebin-database ./database/
  # Starting MariaDB container
  $ docker run -d -p 3306:3306 --name maria -e MARIADB_ROOT_PASSWORD=<mypassword> pastebin-database

  # Install dependencies libs 
  $ sudo cpan install Config::Simple JSON LWP::UserAgent DBIx::Custom

  # Start the crawler
  $ perl app.pl
```


### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [**See here the contribution guidelines.**](/.github/CONTRIBUTING.md) Please, report bugs via [**issues page.**](https://github.com/NozakiLabs/pastebin_crawler/issues) See here the [**Security Policy.**](./github/SECURITY.md) (✿ ◕‿◕) 

### License

- This work is licensed under [**MIT License.**](https://github.com/NozakiLabs/pastebin_crawler/blob/master/LICENSE.md)