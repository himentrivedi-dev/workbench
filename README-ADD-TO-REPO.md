# Curated Engineering & Validation Kit
Skills: backend-engineering (Python/FastAPI/API/architecture/security), test-strategy-engineering (risk-based testing), playwright-e2e-testing (browser automation and artifacts), deployment-engineering (Spinnaker and platform-neutral CI/CD), evidence-driven-validation (checkpoint evidence and signoff).
Copy/merge .claude/, validation/, and scripts/ into repository root. Do not overwrite existing files blindly.
The skills guide Claude; they do not install Playwright, configure Spinnaker, execute CI, or create real audit evidence automatically. Those depend on project tools, permissions and environment.
Screenshot helper requires Pillow: `python -m pip install Pillow`. Example:
```bash
python scripts/annotate_evidence.py input.png output-annotated.png --box 250,180,900,420 --label "UI-003: confirmation total displayed" --status PASS
```
Original screenshot is not modified. Review annotations manually.
