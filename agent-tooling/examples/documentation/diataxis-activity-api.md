# Worked Example: Diátaxis for an Activity Retrieval API

| Type | Reader question | Example document |
|---|---|---|
| Tutorial | "How do I make my first successful search?" | Quickstart: authenticate, send a query, inspect results |
| How-to | "How do I filter by date or location?" | Filter activities by dates, guests, and geographic area |
| Explanation | "How does hybrid retrieval work?" | Structured, lexical, vector, and geographic retrieval concepts |
| Reference | "What fields and errors does the API expose?" | Endpoint, request/response schema, status codes, limits |

## Audit example

A single document currently explains embeddings, lists every request field, walks through authentication, and includes troubleshooting.

Split it by reader task:
- Keep the first successful end-to-end journey in the tutorial.
- Move specific filtering and troubleshooting procedures into how-to guides.
- Explain retrieval and ranking concepts in an explanation.
- Keep exact endpoint and schema facts in reference material.

## Quality checks

- A new reader can complete the tutorial without hidden prerequisites.
- A how-to guide solves one defined task.
- Explanations answer why/how without becoming API field catalogues.
- Reference pages match the current API contract.
- Links connect related documents without duplicating content.
