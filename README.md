<p align="center">
  <h3 align="center">Harpoon</h3>
  <p align="center">An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data</p>
  <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/htrgouvea/harpoon/releases">
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


- You can inspect the database schema in [api/database/database.sql](/Users/htrgouvea/Documents/harpoon/api/database/database.sql).

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
  $ git clone https://github.com/htrgouvea/harpoon && cd harpoon

  # Start the REST API stack from the current api/ directory
  $ cd api
  $ cat > .env <<'EOF'
  APPLICATION_PORT=5000
  DATABASE_HOST=db
  DATABASE_PORT=5432
  DATABASE_NAME=harpoon
  DATABASE_USER=harpoon
  DATABASE_PASSWORD=harpoon
  EOF

  # Build and start Postgres + API
  $ docker compose up --build -d

  # API will be available on http://localhost:5000
```

---

### Contribution

Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page](https://github.com/htrgouvea/harpoon/issues) and for security issues, see here the [security policy.](/SECURITY.md) (✿ ◕‿◕)

---

### License

This work is licensed under [MIT License.](/LICENSE.md)
