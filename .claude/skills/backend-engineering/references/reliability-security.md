# Reliability and Security
Reliability: timeouts on network/DB calls; retry only transient failures with bounded attempts/backoff/jitter; safe idempotency; handle cancellation and partial failure; bound queues/results; monitor latency, errors, saturation, queue depth.
Security: authenticate and authorize; least privilege; validate untrusted input; protect secrets; redact logs/traces/errors; review SSRF, injection, deserialization, path traversal, mass assignment; patch and scan dependencies.
Review: what can fail, be abused, repeated, or grow without bound?
