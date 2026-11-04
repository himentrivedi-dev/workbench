# Advanced Lodging Search Query Cases

Five deliberately non-trivial cases for testing beyond simple destination + budget searches.

These are **test prompts and expected-behavior specifications**, not a scored golden set yet. Do not invent property IDs or relevance labels. Populate qrels only after running against a frozen catalog/inventory snapshot and having eligible properties judged by a human or authoritative business rules.

## Case 1 — Dense hard constraints with occupancy and policy

**Query**

> We're travelling to Singapore from 12–16 December 2026: two adults and two children aged 4 and 9, one room. Find a hotel within 2 km of Marina Bay Sands, with a swimming pool and a room that explicitly accommodates all four of us. Total nightly price must be no more than SGD 350 including mandatory taxes and fees. Free cancellation until at least 48 hours before check-in would be ideal.

**Expected interpretation**

- Hard: Singapore; 12–16 Dec 2026; 2 adults + children aged 4 and 9; one room; within 2 km of Marina Bay Sands; pool; occupancy capacity for all four; total nightly price including mandatory taxes/fees <= SGD 350.
- Soft: free cancellation at least 48 hours before check-in.
- Do not infer child occupancy from the adult-only room capacity.
- Do not compare a base rate against an all-in budget.

**Must-pass checks**

- Correct dates, child ages, room count and occupancy passed to availability search.
- Distance measured from the resolved landmark coordinates using the agreed distance method.
- Room-level capacity and pool are grounded in source data.
- Price basis is explicit; exclude or flag options whose mandatory fees cannot be verified.
- Cancellation preference affects ranking, not hard eligibility.

**Primary dimensions:** query parsing, occupancy, hard constraints, price/fee correctness, geo, policy grounding.

## Case 2 — Spatial intent and nuanced soft preference

**Query**

> I need somewhere to stay in Tokyo for 3 nights from 5 December. Ideally I can walk to Shinjuku Station in about 10 minutes, but I don't want to be right in the middle of the nightlife or on a noisy main road. A quiet place with a 24-hour front desk is more important than having a gym. Budget is around JPY 22,000 per night.

**Expected interpretation**

- Hard: Tokyo; 5–8 Dec 2026; budget ceiling should be clarified or treated as a soft target because “around” is not a strict maximum.
- Spatial preference: approximately 10 minutes' walk to Shinjuku Station; walking time requires pedestrian-network routing, not straight-line distance.
- Soft, ranked: quiet location first; 24-hour front desk; gym is low priority.
- “Not in the middle of nightlife” is a negative spatial/context preference, not a request to exclude the whole Shinjuku area.

**Must-pass checks**

- Do not equate 800 metres straight-line distance with a 10-minute walk.
- Use walking routes or label the estimate as approximate if routing is unavailable.
- Do not claim a property is quiet without evidence (reviews, noise data, or a clearly labelled proxy).
- Preserve the preference ordering: quiet > 24-hour front desk > gym.
- Show budget currency and whether taxes/fees are included.

**Primary dimensions:** geo relevance, soft-preference ranking, groundedness, price interpretation.

## Case 3 — Missing destination entity; clarify before retrieval

**Query**

> I have a late arrival on 18 December and need a hotel close to the airport for one night. It should have a free airport shuttle because I'll be travelling with my parents and lots of luggage.

**Expected interpretation**

- Missing critical entity: which airport/city. Do not guess based on a popular airport or user location unless reliable conversation context explicitly establishes it.
- Likely stay: night of 18 Dec 2026, but confirm check-in/check-out convention if the product requires exact dates.
- Hard: free airport shuttle, if “should have” is treated as mandatory; confirm whether a shared shuttle is acceptable if that distinction matters.
- Soft/context: close to airport; travelling with parents and luggage.

**Expected system action**

Ask one concise clarification: **“Which airport or city are you arriving at?”** Do not call lodging retrieval until the destination is resolved.

**Must-pass checks**

- Correctly identify the missing required slot.
- Ask a focused clarification instead of returning guessed hotels.
- Do not silently convert “free airport shuttle” into “paid transfer” or generic airport proximity.

**Primary dimensions:** slot completeness, clarification precision, tool-call discipline, hard amenity/policy grounding.

## Case 4 — Code-mixed query, local currency and amenity normalization

**Query**

> Bengaluru mein airport ke paas hotel chahiye, 10–12 Dec, 2 adults. Airport se max 3 km ho, free airport shuttle zaroori hai, breakfast included ho toh better. Budget ₹6,000 per night se zyada nahi, taxes included.

**Expected interpretation**

- Language: Hindi-English code-mix; normalize without losing the original meaning.
- Hard: Bengaluru; 10–12 Dec 2026; 2 adults; within 3 km of the resolved airport; free airport shuttle; nightly all-in price <= INR 6,000.
- Soft: breakfast included.
- Ambiguity to handle: Bengaluru has more than one aviation-related location; in normal lodging context, resolve Kempegowda International Airport only if the system's entity-resolution policy supports that interpretation with high confidence. Otherwise ask which airport.

**Must-pass checks**

- Preserve INR, budget amount and tax-inclusive basis.
- Do not translate or drop “zaroori” (mandatory) and “better” (preference).
- Verify shuttle is free, not merely available.
- Verify airport distance against the resolved airport entity.
- Report whether breakfast is included in the offered rate, not merely available for purchase.

**Primary dimensions:** multilingual/code-mix robustness, entity resolution, currency/fees, amenity and policy grounding.

## Case 5 — Contradictory spatial constraints; detect infeasibility

**Query**

> Find a hotel in Paris for 20–22 December, under EUR 180 per night, with a pool. It must be within 500 metres of the Eiffel Tower and also at least 10 km away from the Eiffel Tower. Don't relax either distance requirement.

**Expected interpretation**

- Hard: Paris; 20–22 Dec 2026; nightly price < EUR 180; pool.
- Contradiction: the same property cannot be both within 500 m and at least 10 km from the same landmark.
- Do not silently drop one distance condition or return properties satisfying only one.

**Expected system action**

Identify the conflict and ask which distance condition should take precedence. If the user insists both remain mandatory, return a typed infeasible outcome without calling retrieval or presenting fabricated matches.

**Must-pass checks**

- Detect mutually exclusive constraints before retrieval.
- Explain the exact conflict briefly.
- Do not convert a hard constraint into a soft preference without permission.
- Distinguish “infeasible request” from “no inventory found”.

**Primary dimensions:** contradiction detection, hard-constraint compliance, clarification, infeasibility handling.

## How to turn these into a scored evaluation set

1. Run each prompt through the actual production query interface and capture parsed intent, entities, dates, occupancy, hard/soft constraints, clarification decision, tool calls and raw candidates.
2. Freeze the catalog/index and price/availability snapshot used for each run.
3. For retrieval cases (1, 2 and 4), adjudicate eligible property IDs and graded relevance labels. Record source evidence and snapshot timestamps.
4. For clarification/infeasibility cases (3 and 5), score the expected action and verify that retrieval was not called prematurely. Do not pass these cases into Recall@K/NDCG calculations as empty-qrel examples.
5. Repeat stochastic cases at least three times and compare both action consistency and parsed-field consistency.
6. Keep these five as a compact regression seed; expand with real, de-identified production queries before using aggregate scores as release gates.
