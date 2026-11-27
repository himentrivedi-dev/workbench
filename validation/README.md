# Validation artifacts
Suggested layout:
```
validation/
  templates/
    validation-plan.md
    checkpoint-matrix.csv
    execution-summary.md
  runs/<change-or-release-id>/
    validation-plan.md
    checkpoint-matrix.csv
    execution-summary.md
    evidence/
      original/
      annotated/
      playwright-traces/
      api/
      logs/
      reports/
```
Do not commit secrets, tokens, customer personal data, production payloads, or unrestricted logs. Follow organizational retention/access policy. Store large or sensitive evidence in an approved artifact system and link it from the matrix.
