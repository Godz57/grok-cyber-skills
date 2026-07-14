---
name: cyber
description: >
  Router for the 817-skill Anthropic-Cybersecurity-Skills library (mode D).
  Search index, load 1–3 playbooks on demand, execute authorized workflows.
  Use when user asks SOC, DFIR, threat hunt, IR, cloud security, red team,
  malware, forensics, MITRE ATT&CK, /cyber, /cyber-find, /cyber-run.
  NEVER load all skills. NEVER use against unauthorized systems.
metadata:
  short-description: "Cyber playbook router (817 skills)"
  author: "Grok mode-D wrapper for mukul975/Anthropic-Cybersecurity-Skills"
---

# cyber (Grok mode D)

You **index and load** skills from the upstream library. You do **not** install
all 817 skills into Grok’s always-on skill list.

Announce: `Using cyber router — on-demand load only.`

## Toolkit path

Resolve **TOOLKIT** as first that exists:

1. `~/.grok/tools/cyber-skills`  
2. `./.grok/tools/cyber-skills`  
3. User-specified path  

Must contain `index.json` and `skills/`.

If missing → tell user to run `grok-cyber-skills/scripts/install.ps1` (or `.sh`).

## Hard rules

1. **Progressive disclosure** — search index first; open full `SKILL.md` only for top matches (default **max 3**).
2. **Never** dump hundreds of skill bodies into context.
3. **Authorization** before offensive / dual-use procedures against live systems:
   - Lab, own infra, written RoE → OK  
   - Third-party / ambiguous → **refuse**  
4. Prefer **defensive** workflows when intent is unclear.
5. After following a skill: report steps taken, evidence, MITRE IDs if present, residual risk.
6. Do not invent tool output — run tools only if available; else document prerequisites.

## Search (prefer script)

```bash
python ~/.grok/skills/cyber/scripts/cyber_search.py "query words" --limit 8
# or TOOLKIT-relative if installed with skill:
python TOOLKIT_OR_SKILL/scripts/cyber_search.py "memory forensics lsass" -n 5
```

Windows: same with `python` and full path under `%USERPROFILE%\.grok\...`.

If script missing: read `TOOLKIT/index.json` and rank by keyword overlap on `name` + `description`.

## Workflow

### A) User has a task (default)

1. Extract keywords from the request  
2. Run search → show top hits (name + one-line description)  
3. Pick best 1–3 (ask if ties / high risk offensive)  
4. `read_file` each `TOOLKIT/<path>/SKILL.md`  
5. Optionally load `references/` only if needed for detail  
6. Execute **Workflow** section; use **Verification**  
7. Auth gate if actions hit networks/systems beyond local analysis of user-provided artifacts  

### B) Explicit skill name (`/cyber-run <name>`)

1. Resolve path via index `name` field  
2. Load that `SKILL.md` only  
3. Execute as above  

### C) Domain browse (`/cyber-domain <word>`)

1. Search name/description/path for word (forensics, cloud, web, phishing…)  
2. List up to 20 names; do not load bodies until user picks  

## Offensive content

Skills may describe red-team / exploit techniques. Treat as **authorized research only**.  
If user asks to attack a system they do not own → refuse; offer defensive skill or their own lab.

## Integration

| Need | Prefer |
|------|--------|
| Vibe app OWASP quick | `/pentest-whitebox` |
| Agentic PoC pentest | `/strix-scan` |
| Code quality | `code-craftsman` |
| Broad cyber procedure | **this router** |

## Output shape

```markdown
## Cyber router
**Query:** ...
**Matches:** (table name | score | blurb)
**Loaded:** skill-a, skill-b
**Auth:** n/a | confirmed | refused

### Execution
...

### Verification / findings
...
```
