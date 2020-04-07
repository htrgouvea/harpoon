<p align="center">
  <img src="https://i.imgur.com/oQttGq1.jpg" height="150px" width="150px">
  <p align="center">"if i reach out my hands, they touch your privacy"</p>
  <h1 align="center">Uranus</h1>
  <p align="center">
    An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data
  </p>
  <p align="center">
    <a href="https://github.com/GouveaHeitor/uranus/blob/master/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/GouveaHeitor/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.1.1-blue.svg">
    </a>
  </p>
</p>

---


### How it works

```
  This project is summarized in several crawlers that constitute a single ecosystem, that monitor certain
  channels such as: Github, Bing, Pastebin and iHaveBeenPwned? in order to perform data leak detection,
  exposed sensitive files and data exfiltration attempts.
```

![Image](https://i.imgur.com/VRXVgt3.png)

### Download and setup:

```bash
  # Download
  $ git clone https://github.com/GouveaHeitor/uranus
  $ cd uranus

  # Building MariaDB Database
  $ docker build --rm --squash -t uranus-database ./database/

  # Starting MariaDB container
  $ docker run -d -p 3306:3306 --name maria -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

  # Building all crawlers containers
  $ docker build --rm --squash -t uranus-pastebin-crawler ./crawlers/pastebin/
  $ docker build --rm --squash -t uranus-bing-crawler ./crawlers/bing/
  $ docker build --rm --squast -t uranus-github-crawler ./crawlers/github/
  $ docker build --rm --squash -t uranus-ihavebeenpwned-crawler ./crawlers/ihavebeenpwned

  # Running all crawlers
  $ docker run 
  $ docker run
  $ docker run
  $ docker run
```

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page.](https://github.com/GouveaHeitor/uranus/issues) See here the [security policy.](./github/SECURITY.md) (✿ ◕‿◕) This project follows the best practices defined by this [style guide](https://heitorgouvea.me/projects/perl-style-guide).

### License

- This work is licensed under [MIT License.](/LICENSE.md)
