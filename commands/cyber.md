---
description: Cyber skills router — find/run playbooks from the 817-skill library
argument-hint: "[find <q> | run <name> | domain <word> | status]"
---

# /cyber

Load skill `cyber` (`~/.grok/skills/cyber/SKILL.md`).

| Args | Action |
|------|--------|
| empty | Ask task; then search + load |
| `find ...` | `/cyber-find` |
| `run <name>` | `/cyber-run` |
| `domain ...` | `/cyber-domain` |
| `status` | `/cyber-status` |

Progressive disclosure only. Auth gate for offensive live targets.
