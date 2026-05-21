## Pastebin crawler

The Pastebin crawler polls the public scraping API, skips paste keys already present in `pastebin_history`, then inspects each unseen paste against stored rules.

### Detection model

- `WORD` is the primary company keyword that must appear in the paste body.
- `FILTER` is a slash-delimited list of supporting terms. At least one supporting term must also appear.
- Matching now runs through `crawlers/lib/Harpoon/Crawler/DetectionEngine.pm`, which keeps the detection rules separate from source-specific HTTP code.

### Default supporting terms

`HACK / HACKED / OWNED / PAWNED / PWNED / HACKIADO / HACKIADA / HACKEADO / VAZAMENTO / VAZADO / VAZADA / LEAK / LEAKED / INVASAO / INVADIDA / INVADIDO / DEFACE / DEFACEMENT / H4CK / H4CK3D / OWN3D / PWN3D / P3WN3D / H4CK14D0 / H4CK14D4 / V4Z4M3NT0 / V4Z4D0 / L34K / L34K3D / INV4S40 / INV4D1D4 / INV4D1D0 / D3F4C3 / D3F4C3M3NT`

### Engineering notes

- History and alert inserts now use the shared detection store module, which centralizes existence checks and record creation.
- The crawler only processes Pastebin's public scraping feed. It does not include private-paste access or breach-dataset enrichment.
