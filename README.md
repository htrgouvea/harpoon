<p align="center">
  <h3 align="center">Harpoon</h3>
  <img src="https://heitorgouvea.me/images/projects/uranus/logo.jpg" width="150px" height="150px">
  <p align="center">An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data</p>
  <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/GouveaHeitor/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.1.6-blue.svg">
    </a>
  </p>
</p>

---

### Summary

⚠️ __Warning:__ Harpoon is currently in __development__, you've been warned :) and please consider [contributing!](/.github/CONTRIBUTING.md)

This project is summarized in several crawlers that constitute a single ecosystem, that monitor certain channels such as: Github, Bing, Pastebin and iHaveBeenPwned? in order to perform data leak detection, exposed sensitive files and data exfiltration attempts.

---

### How it works

![Image](/files/Diagram.png)


- You can [click here](/rest-server/database/README.md) to see a diagram of the database and also a catalog on them.

---

### Download and setup

```bash
  # Download
  $ git clone https://github.com/GouveaHeitor/uranus && cd uranus

  # Building and starting MariaDB Database
  $ docker build -t uranus-database ./rest-server/database/
  $ docker run -d -p 3306:3306 --name database -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

  # Building and starting the REST API
  $ docker build -t uranus-rest-server ./rest-server.
  $ docker run -d -p 80:80 --name rest-server uranus-rest-server

  # Building all crawlers/workers containers
  $ docker build -t bing-crawler ./crawlers/bing/
  $ docker build -t email-notify ./workers/email-notify

  # Running all crawlers/workers containers
  $ docker run -d --name bing bing-crawler
  $ docker run -d --name email-notify email-notify
```

---

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page](https://github.com/GouveaHeitor/uranus/issues) and for security issues, see here the [security policy.](/SECURITY.md) (✿ ◕‿◕) This project follows the best practices defined by this [style guide](https://heitorgouvea.me/projects/perl-style-guide).

- If you are interested in providing financial support to this project, please visit: [heitorgouvea.me/donate](https://heitorgouvea.me/donate)

---

### License

- This work is licensed under [MIT License.](/LICENSE.md)
