<p align="center">
  <h1 align="center">Uranus</h1>
  <p align="center">
    An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data
  </p>

  <p align="center">
    <a href="https://github.com/NozakiLabs/uranus/blob/master/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/NozakiLabs/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.9-blue.svg">
    </a>
  </p>
</p>

---


### How it works

```
```

### Download and setup:

```bash
  # Download
  $ git clone https://github.com/NozakiLabs/uranus
  $ cd uranus

  # Building MariaDB Database
  $ docker build --rm --squash -t uranus-database ./database/

  # Starting MariaDB container
  $ docker run -d -p 3306:3306 --name maria -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

  # Building Pastebin Crawler container
  $ docker build --rm --squash -t uranus-pastebin-crawler ./crawlers/pastebin/

  # 
```


### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [**See here the contribution guidelines.**](/.github/CONTRIBUTING.md) Please, report bugs via [**issues page.**](https://github.com/NozakiLabs/uranus/issues) See here the [**security policy.**](./github/SECURITY.md) (✿ ◕‿◕) 

### License

- This work is licensed under [**MIT License.**](https://github.com/NozakiLabs/uranus/blob/master/LICENSE.md)