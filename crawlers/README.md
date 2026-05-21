# Crawlers

Harpoon's crawler layer is responsible for collecting candidate artifacts from external sources and converting them into normalized detections for the rest of the platform.

## Current layout

- `bing/`: search-engine based discovery for publicly indexed URLs that match stored rules.
- `pastebin/`: pull recent public pastes and match them against company keywords plus supporting filter terms.
- `lib/Harpoon/Crawler/DetectionEngine.pm`: shared content-matching logic for crawler detections.
- `lib/Harpoon/Crawler/DetectionStore.pm`: shared persistence helpers for de-duplication and inserts.

## Design notes

- Crawlers should only inspect sources the operator is authorized to monitor.
- Detection logic belongs in reusable modules under `crawlers/lib` instead of being duplicated inside source-specific entrypoints.
- New crawlers should emit normalized alerts and reuse the shared detection modules whenever possible.

## Safe expansion path

Supported future work should prefer documented, authorized integrations such as code-hosting webhooks, company-owned communication exports, and notification workers. Avoid implementing collectors that depend on breached datasets, private-group scraping, or unauthorized account access.
