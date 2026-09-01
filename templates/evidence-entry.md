# Evidence entry template

```yaml
claim_id: C-001
claim: "..."
state: current | historical | transitional
valid_time_range: "YYYY-MM-DD..YYYY-MM-DD | current | unknown"
confidence: high | medium | low
sources:
  - type: code | config | test | github_pr | github_commit | jira | confluence | other
    locator: "precise URL / issue key / PR / SHA / file:line"
    date: "YYYY-MM-DD"
    role: supports | contradicts | supersedes | motivation | context
notes: "..."
```
