---
description: Load and execute one cybersecurity playbook by skill name
argument-hint: "<skill-name-kebab-case>"
---

# /cyber-run

1. Resolve name from `$ARGUMENTS` (exact kebab name preferred).
2. Look up in `~/.grok/tools/cyber-skills/index.json`.
3. Read **only** `TOOLKIT/<path>/SKILL.md`.
4. Auth gate if Workflow requires attacking/probing non-local systems.
5. Execute Workflow; use Verification; load `references/` only if needed.
6. Report outcomes + MITRE/framework IDs when present in the skill.
