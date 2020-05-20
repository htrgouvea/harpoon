<p align="center">
  <img src="https://heitorgouvea.me/images/projects/uranus/logo.jpg" height="150px" width="150px">
  <p align="center">"if i reach out my hands, they touch your privacy"</p>
  <h1 align="center">Uranus</h1>
  <p align="center">
    An ecosystem of crawlers for detecting: leaks, sensitive data exposure and attempts exfiltration of data
  </p>
  <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
    <a href="https://github.com/GouveaHeitor/uranus/releases">
      <img src="https://img.shields.io/badge/version-0.1.1-blue.svg">
    </a>
  </p>
</p>

---


⚠️ __Warning:__ Uranus is currently in __beta__, you've been warned :) and please consider [contributing](./github/CONTRIBUTING.md)

### How it works

```
  This project is summarized in several crawlers that constitute a single ecosystem, that monitor certain
  channels such as: Github, Bing, Pastebin and iHaveBeenPwned? in order to perform data leak detection,
  exposed sensitive files and data exfiltration attempts.
```

![Image](https://heitorgouvea.me/images/projects/uranus/architecture.png)

### Download and setup:

```bash
  # Download
  $ git clone https://github.com/GouveaHeitor/uranus && cd uranus

  # Building and starting MariaDB Database
  $ docker build --rm --squash -t uranus-database ./database/
  $ docker run -d -p 3306:3306 --name database -e MARIADB_ROOT_PASSWORD=mypassword uranus-database

  # Building all crawlers and workers containers
  $ docker build --rm --squash -t pastebin-crawler ./crawlers/pastebin/
  $ docker build --rm --squash -t bing-crawler ./crawlers/bing/
  $ docker build --rm --squash -t email-notify ./workers/email-notify

  # Running all crawlers
  $ docker run -d --name pastebin pastebin-crawler
  $ docker run -d --name bing bing-crawler
  $ docker run -d --name email-notify  email-notify
```

### Basic filters

  - Pastebin: HACK / HACKED / OWNED / PAWNED / PWNED / HACKIADO / HACKIADA / HACKEADO / VAZAMENTO / VAZADO / VAZADA / LEAK / LEAKED / INVASAO / INVADIDA / INVADIDO / DEFACE / DEFACEMENT / H4CK / H4CK3D / OWN3D / PWN3D / P3WN3D / H4CK14D0 / H4CK14D4 / V4Z4M3NT0 / V4Z4D0 / L34K / L34K3D / INV4S40 / INV4D1D4 / INV4D1D0 / D3F4C3 / D3F4C3M3NT

  - Bing: 

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page.](https://github.com/GouveaHeitor/uranus/issues) See here the [security policy.](/SECURITY.md) (✿ ◕‿◕) This project follows the best practices defined by this [style guide](https://heitorgouvea.me/projects/perl-style-guide).

### License

- This work is licensed under [MIT License.](/LICENSE.md)
