<p align="center">
  <h3 align="center">Harpoon</h3>
  <p align="center">An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data</p>
  <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/GouveaHeitor/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.1.6-blue.svg">
    </a>
    <br/>
    <img src="https://github.com/htrgouvea/harpoon/actions/workflows/linter.yml/badge.svg">
    <img src="https://github.com/htrgouvea/harpoon/actions/workflows/zarn.yml/badge.svg">
    <img src="https://github.com/htrgouvea/harpoon/actions/workflows/security-gate.yml/badge.svg">
  </p>
</p>

---

### Summary

⚠️ __Warning:__ Harpoon is currently in __development__, you've been warned :) and please consider [contributing!](/.github/CONTRIBUTING.md)

This project is summarized in several crawlers that constitute a single ecosystem, that monitor public or otherwise authorized channels such as code hosting, search engines and paste sites in order to perform leak detection, exposed sensitive file discovery and data exfiltration monitoring.

---

### How it works

![Image](/files/Diagram.png)


- You can [click here](/rest-server/database/README.md) to see a diagram of the database and also a catalog on them.

### Current implementation focus

- REST API for alerts, companies, history and rules
- Bing crawler for public search discovery
- Pastebin crawler for public paste monitoring
- Shared crawler detection modules for matching and persistence

### Roadmap constraints

Future integrations should stay within authorized monitoring boundaries. Safe next steps include API hardening, notification workers, dashboards, and documented integrations with approved data sources. This repository should not rely on breached credential datasets, hidden services, or scraping private groups or accounts.

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

Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page](https://github.com/GouveaHeitor/uranus/issues) and for security issues, see here the [security policy.](/SECURITY.md) (✿ ◕‿◕)

---

### License

This work is licensed under [MIT License.](/LICENSE.md)
