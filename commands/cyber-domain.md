---
description: List cyber skills matching a domain keyword (forensics, cloud, web, ...)
argument-hint: "<keyword>"
---

# /cyber-domain

1. Run search with domain-ish keywords:

```powershell
python "$env:USERPROFILE\.grok\skills\cyber\scripts\cyber_search.py" $ARGUMENTS --limit 20
```

2. List names only (no full skill bodies).
3. Invite user to `/cyber-run <name>` for one playbook.
