# Non-Publishable Workspace Material

This directory contains material that is useful for provenance, development, validation, or benchmark construction but is not part of the canonical public benchmark release surface.

Typical contents:

- raw or extracted upstream source trees used during benchmark construction
- validation scripts and generated validation reports
- benchmark generation utilities
- generated caches and local tool artifacts
- candidate-source notes used during curation

The public benchmark artifact should use `data/`, `release/`, `scripts/`, `docs/`, `README.md`, `LICENSE`, `THIRD_PARTY_NOTICES.md`, and `PUBLICATION_MANIFEST.md` as the release surface.

Do not cite files in this directory as benchmark instances. Cite the corresponding curated assets under `data/` and generated annotations under `release/`.
