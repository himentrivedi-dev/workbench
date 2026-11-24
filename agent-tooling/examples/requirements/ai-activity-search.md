# Worked Example: AI Activity Search Requirements

**Status:** Illustrative reference example. Validate all thresholds and product behaviour with the product owner before implementation.

## Problem

A traveller asks for an activity that is "something relaxing near the water." The search experience should return relevant activities without treating an inferred preference as a mandatory constraint.

## Business outcome

Help travellers discover activities that fit their stated intent and provide enough information to decide whether to explore or book.

## Functional requirements

- Interpret "relaxing" as a preference signal, not a guaranteed objective classification.
- Identify water proximity as a relevance signal unless the user explicitly makes it mandatory.
- Return activities with available, grounded descriptions and location information.
- Explain the main reason a result is relevant when source data supports the explanation.
- Ask for clarification when missing information prevents a useful search; do not invent dates or location.

## Non-functional requirements

- Define latency targets with product and engineering owners; do not invent an SLO.
- Preserve hard filters such as date, guest count, and availability when supplied.
- Make ranking reproducible enough to evaluate against a labelled query set.
- Record retrieval and ranking signals needed for debugging.

## Acceptance criteria

**Preference interpretation**

Given a user asks for "something relaxing near the water"
When the query is interpreted
Then relaxation and water proximity are represented as preference signals
And neither is silently converted into a hard filter.

**Hard constraint preservation**

Given the user specifies a date and guest count
When results are retrieved
Then candidates that violate confirmed availability or guest constraints are excluded.

**Insufficient location context**

Given no usable location is present in the request or session
When proximity is essential to the search
Then the system asks for a location instead of guessing one.

## Traceability starter

| Requirement | Acceptance criterion | Test |
|---|---|---|
| Preference is not a hard filter | Preference interpretation | Query interpretation unit test |
| Hard constraints are enforced | Hard constraint preservation | Retrieval integration test |
| Location is not fabricated | Insufficient location context | Missing-context negative test |

## Open decisions

- What qualifies as "near" for each activity category?
- Which source fields support relaxation and water proximity?
- How should the system behave when source metadata is incomplete?
- What is the target latency and what is the measurement boundary?
