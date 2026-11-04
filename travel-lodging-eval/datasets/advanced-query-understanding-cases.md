# Advanced Query Understanding & Constraint Reasoning Cases

Seven deliberately difficult lodging-search prompts covering negative presence, indirect context, conflicting preferences, ambiguity, negation scope, and contextual trade-offs.

These are **test prompts with expected-behaviour specifications**, not a scored golden set. Do not invent property IDs or relevance labels. For retrieval cases, populate qrels only after running against a frozen catalog/inventory snapshot and having eligible properties judged using authoritative data or human review.

## Case 6 — Negative presence and exclusion scope

**Query**

> Find me a hotel in Bangkok for 3 nights from 14 December. I don't want a property with a casino, nightclub, or bar inside it. Avoid hotels on streets with heavy nightlife. A swimming pool and breakfast would be nice. Budget is THB 4,000 per night.

**Expected interpretation**

- Hard exclusions: casino, nightclub, and bar within the property.
- Negative location preference: avoid streets with heavy nightlife.
- Soft positive preferences: swimming pool and breakfast.
- Budget: THB 4,000/night; clarify or preserve as a target unless the product's query policy treats an unqualified budget as a cap.
- The date resolves to 14–17 Dec 2026 if the current conversation establishes 2026; otherwise resolve the year from context or clarify.

**Must-pass checks**

- Distinguish property-level exclusions from neighbourhood-level negative preferences.
- Do not treat an unmentioned amenity as confirmed absent. Unknown is not equivalent to false.
- Do not exclude an entire neighbourhood solely because it contains nightlife; assess the stated street-level preference.
- Preserve pool and breakfast as ranking preferences, not mandatory filters.
- Surface evidence or uncertainty for claims about bars, clubs, casinos, and nightlife.

**Primary dimensions:** negative constraint extraction, exclusion scope, data completeness, evidence grounding.

## Case 7 — Indirect context and cautious inference

**Query**

> I'm travelling with my elderly parents to Rome. We'll be sightseeing during the day and returning to the hotel in the evening. Find somewhere convenient for 4 nights from 10 December. I don't want us to struggle every time we enter or leave the property. Budget is around EUR 220 per night.

**Expected interpretation**

- Contextual need: easy access to and from the property; accessibility and minimal physical barriers may matter.
- Potentially useful attributes: lift, step-free entrance, limited stairs, accessible transport, and convenient drop-off.
- Budget: approximately EUR 220/night, not necessarily a strict ceiling.
- The query does not establish wheelchair use, a disability, or a specific mobility limitation.

**Expected system action**

- Prioritise properties with verified easy-access features and convenient transport.
- Ask a focused follow-up if a specific accessibility requirement is needed to filter safely (for example, step-free access throughout).
- Do not infer a medical condition or assume wheelchair accessibility is required.

**Must-pass checks**

- Detect the indirect access requirement.
- Separate reasonable contextual inference from unsupported personal assumptions.
- Ground accessibility claims in property data; unknown fields must remain unknown.
- Avoid ranking luxury amenities above access convenience.

**Primary dimensions:** implicit intent, cautious inference, accessibility grounding, clarification.

## Case 8 — Conflicting soft preferences and preference prioritisation

**Query**

> Find a hotel in central London for 3 nights from 15 December. I want to be close to restaurants, shopping and nightlife, but I also want somewhere extremely quiet with no street noise. Ideally, it should be within walking distance of everything. Budget is GBP 250 per night.

**Expected interpretation**

- Positive location preferences: central, near restaurants, shopping, and nightlife.
- Competing preference: extremely quiet, with no street noise.
- “Walking distance of everything” is broad and needs interpretation against the actual places of interest.
- Budget is GBP 250/night; clarify whether it is a hard maximum if that distinction changes eligibility.
- Quietness should be prioritised through quieter streets, room orientation, floor, and verified soundproofing where available.

**Expected system action**

- Seek a compromise: quieter street or room within practical walking distance of central attractions.
- If the system cannot determine the priority, ask whether quietness or immediate nightlife proximity matters more.
- Do not label a property “noise-free” without strong evidence.

**Must-pass checks**

- Keep conflicting soft preferences distinct; do not turn both into hard filters.
- Apply the user's stated emphasis on quietness when ranking trade-offs.
- Use walking-network estimates rather than straight-line distance when reporting walkability.
- Distinguish verified soundproofing from review-derived or inferred quietness.

**Primary dimensions:** preference conflict resolution, ranking rationale, geo relevance, evidence calibration.

## Case 9 — Contradictory hard constraints and pre-retrieval validation

**Query**

> Find a hotel in Singapore for 2 nights from 20 December. It must be within 500 metres of Changi Airport and at least 15 km away from Changi Airport. Both conditions are mandatory. Do not relax either requirement.

**Expected interpretation**

- Hard constraints: Singapore; 20–22 Dec 2026; within 500 m of Changi Airport; at least 15 km from the same airport.
- The two distance constraints are mutually exclusive when measured from the same reference point using the same distance method.

**Expected system action**

Identify the contradiction and ask which distance condition should take priority. If both remain mandatory, return a typed infeasible outcome without invoking lodging retrieval.

**Must-pass checks**

- Detect the contradiction before retrieval.
- Explain the exact conflict without silently relaxing either condition.
- Distinguish infeasibility from zero inventory.
- Do not return candidates that satisfy only one of the mandatory distance constraints.

**Primary dimensions:** constraint consistency, infeasibility detection, tool-call discipline.

## Case 10 — Ambiguity and missing critical slots

**Query**

> I need a hotel near the airport for my flight next Friday. I will arrive late, and I don't want to travel far after landing. Find something affordable with breakfast.

**Expected interpretation**

- Critical missing entity: destination city or airport.
- Relative date: “next Friday” must be resolved against the current date and timezone; if the intended date is uncertain, confirm it.
- Ambiguous budget: “affordable” has no numeric threshold.
- Arrival context implies airport proximity is important; it does not identify which airport.

**Expected system action**

Ask which city or airport the traveller is arriving at before lodging retrieval. Ask for a budget range only if needed to make the next step useful.

**Must-pass checks**

- Identify the missing airport/city as a blocking slot.
- Resolve relative dates consistently or ask for confirmation when ambiguous.
- Do not guess the airport from user location or popularity.
- Do not invoke retrieval with an invented destination.
- Preserve breakfast as a preference unless the user makes it mandatory.

**Primary dimensions:** ambiguity detection, slot completeness, temporal resolution, clarification precision.

## Case 11 — Negation scope across room, floor, and property

**Query**

> Find a hotel in Dubai for 4 nights. Smoking should not be allowed in my room. I don't mind if the hotel has a designated smoking area elsewhere. I would prefer a non-smoking floor.

**Expected interpretation**

- Hard: the booked room must be non-smoking.
- Soft: prefer a non-smoking floor.
- Explicitly acceptable: a designated smoking area elsewhere in the property.
- Dates and budget are missing; obtain them before a real availability search if required by the service.

**Must-pass checks**

- Interpret the prohibition at room level, not as a property-wide ban.
- Do not exclude hotels merely because they have a designated smoking area.
- Do not treat a non-smoking floor as mandatory.
- Verify room policy separately from general property policy.
- Ask only for the missing information needed to proceed.

**Primary dimensions:** negation scope, entity/attribute granularity, hard-soft classification, clarification.

## Case 12 — Indirect trade-off and value-sensitive ranking

**Query**

> I'm visiting Amsterdam for a conference. I'll be leaving early every morning and returning late. I don't need luxury facilities, but I need reliable transport to the conference venue and a comfortable place to sleep. I'd rather spend less on the hotel.

**Expected interpretation**

- High-priority needs: reliable transport to the conference venue and a comfortable sleeping environment.
- Low priority: luxury facilities and premium amenities.
- Price sensitivity: prefer lower-cost suitable options, but no exact budget is stated.
- Critical missing slots: conference venue and stay dates.

**Expected system action**

Ask for the conference venue and dates. If useful, ask for a budget range after those details are known. Rank by practical transport, sleep-related evidence, and value rather than star rating or luxury amenities.

**Must-pass checks**

- Infer the ranking priorities without inventing a specific budget.
- Do not overvalue gyms, spas, room upgrades, or star ratings.
- Evaluate route reliability and travel time to the actual venue, not merely city-centre proximity.
- Ground sleep-comfort claims in room attributes or clearly labelled review evidence.
- Do not start retrieval before the venue and dates are sufficiently resolved.

**Primary dimensions:** implicit preference ranking, value sensitivity, geo relevance, missing-slot handling.

## Cross-case evaluation protocol

For every case, capture:

1. **Extraction:** entities, dates, occupancy, positive requirements, negative requirements, and contextual signals.
2. **Classification:** hard constraints, soft preferences, exclusions, uncertain values, and inferred-but-unconfirmed needs.
3. **Consistency:** contradictions, negation scope, and whether the request is feasible.
4. **Action:** search, clarify, or return a typed infeasible result; record whether a tool call was appropriate.
5. **Grounding:** evidence for property attributes, location, accessibility, noise, smoking policy, and price.
6. **Ranking:** whether the ordering reflects the user's priorities and trade-offs.
7. **Stability:** repeat stochastic cases and compare extraction, action, and ranking consistency.

Do not score clarification or infeasibility cases as retrieval failures with empty qrels. For retrieval cases, freeze catalog, routing, price, and availability snapshots; use adjudicated qrels and deterministic assertions wherever possible. Treat synthetic cases as coverage tests, not evidence of production quality.
