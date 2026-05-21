## Bing crawler

The Bing crawler reads `rule` records where `SOURCE = BING`, renders the configured search dork by replacing `$string`, paginates through a small result window, and stores unique URLs in the shared `alert` table.

### How the dork works

- `STRING` is the company-specific token to search for.
- `FILTER` is the full Bing query template, for example `site:example.com "$string" filetype:pdf`.
- The crawler URL-escapes the final query and requests result pages from Bing using the `first=` parameter.
- Collected links are filtered to keep external HTTP/HTTPS results and ignore Bing or Microsoft-owned navigation links.

### Engineering notes

- Result de-duplication is done twice: once in-memory per crawl execution and once against the database using the alert hash.
- Detection persistence now lives in `crawlers/lib/Harpoon/Crawler/DetectionStore.pm`, so new search-based collectors can reuse the same insert flow.
- The crawler is intentionally conservative about the number of result pages it fetches to reduce load and noise.
