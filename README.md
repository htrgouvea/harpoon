<p align="center">
  <h1 align="center">Uranus</h1>
  <p align="center">
    An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data
  </p>
  <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/GouveaHeitor/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.1.3-blue.svg">
    </a>
  </p>
</p>

⚠️ __Warning:__ Uranus is currently in __development__, you've been warned :) and please consider [contributing!](/.github/CONTRIBUTING.md)

---

### Summary

This project is summarized in several crawlers that constitute a single ecosystem, that monitor certain channels such as: Github, Bing, Pastebin and iHaveBeenPwned? in order to perform data leak detection, exposed sensitive files and data exfiltration attempts.

![Image](https://heitorgouvea.me/images/projects/uranus/architecture.png)

---

### Download and setup

```bash
  # Download
  $ git clone https://github.com/GouveaHeitor/uranus && cd uranus

  # Building and starting MariaDB Database
  $ docker build --rm --squash -t uranus-database ./rest-server/migrations/
  $ docker run -d -p 3306:3306 --name database -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

  # Building all crawlers and workers containers
  $ docker build --rm --squash -t bing-crawler ./crawlers/bing/
  $ docker build --rm --squash -t email-notify ./workers/email-notify

  # Running all crawlers
  $ docker run -d --name bing bing-crawler
  $ docker run -d --name email-notify email-notify
```

---

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page.](https://github.com/GouveaHeitor/uranus/issues) See here the [security policy.](/SECURITY.md) (✿ ◕‿◕) This project follows the best practices defined by this [style guide](https://heitorgouvea.me/projects/perl-style-guide).

---

### License

- This work is licensed under [MIT License.](/LICENSE.md)
