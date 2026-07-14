---
description: Search the 817 cybersecurity skills index (on-demand)
argument-hint: "<search terms>"
---

# /cyber-find

1. Require toolkit at `~/.grok/tools/cyber-skills` (or install).
2. Run:

```powershell
python "$env:USERPROFILE\.grok\skills\cyber\scripts\cyber_search.py" $ARGUMENTS --limit 10
```

```bash
python ~/.grok/skills/cyber/scripts/cyber_search.py $ARGUMENTS -n 10
```

3. Show ranked table to user.
4. If user wants execution, `/cyber-run <name>` or load top 1–3 and follow skill `cyber` workflow.
5. Do **not** open all matching SKILL.md files at once.
