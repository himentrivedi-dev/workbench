# Dataset Schema

A JSONL evaluation case should look like:

```json
{
  "case_id": "lodging-000001",
  "query": "family hotel near Dubai Mall with a pool under 250 USD",
  "locale": "en-US",
  "trip": {
    "check_in": "2026-12-10",
    "check_out": "2026-12-13",
    "adults": 2,
    "children": 2,
    "rooms": 1
  },
  "intent": "lodging_search",
  "entities": {
    "destination": "Dubai",
    "landmark": "Dubai Mall"
  },
  "constraints": {
    "hard": [
      {"type": "destination", "value": "Dubai"},
      {"type": "near_landmark", "value": "Dubai Mall", "max_distance_km": 5},
      {"type": "amenity", "value": "pool"},
      {"type": "max_price", "currency": "USD", "amount": 250}
    ],
    "soft": [
      {"type": "traveler_type", "value": "family"}
    ]
  },
  "qrels": [
    {"property_id": "canonical-123", "relevance": 3},
    {"property_id": "canonical-456", "relevance": 2}
  ],
  "geo_target": {
    "latitude": 25.1985,
    "longitude": 55.2796,
    "radius_km": 5
  },
  "source_snapshot": "2026-12-01T00:00:00Z"
}
```

## Required fields

`case_id`, `query`, `locale`, `intent`, `constraints`, and `qrels` are required for retrieval evaluation.

Trip dates/occupancy are required when the search service supports availability.

## Qrel policy

Qrels should come from authoritative or human-validated evidence. Preserve the evidence source and timestamp outside the public repository when the source is proprietary.

## No PII

Do not store names, emails, phone numbers, loyalty IDs, booking IDs, payment data, or raw customer conversations in this dataset. Use de-identified queries and synthetic identifiers.