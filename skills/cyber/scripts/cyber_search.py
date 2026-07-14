#!/usr/bin/env python3
"""Search Anthropic-Cybersecurity-Skills index.json (mode D)."""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path


def default_toolkit() -> Path:
    env = os.environ.get("GROK_CYBER_SKILLS_ROOT")
    if env:
        return Path(env)
    home = Path.home() / ".grok" / "tools" / "cyber-skills"
    if (home / "index.json").is_file():
        return home
    proj = Path.cwd() / ".grok" / "tools" / "cyber-skills"
    if (proj / "index.json").is_file():
        return proj
    return home


def tokenize(q: str) -> list[str]:
    return [t for t in re.split(r"[^a-z0-9]+", q.lower()) if len(t) >= 2]


def score_skill(skill: dict, tokens: list[str]) -> float:
    name = skill.get("name", "").lower()
    desc = skill.get("description", "").lower()
    path = skill.get("path", "").lower()
    blob = f"{name} {desc} {path}"
    s = 0.0
    for t in tokens:
        if t in name:
            s += 4.0
        if t in path:
            s += 2.0
        if t in desc:
            s += 1.5
        # partial kebab segments
        if any(t in part for part in name.split("-")):
            s += 0.5
    # full phrase bonus
    phrase = " ".join(tokens)
    if phrase and phrase in blob:
        s += 3.0
    return s


def main() -> int:
    p = argparse.ArgumentParser(description="Search cyber skills index")
    p.add_argument("query", nargs="+", help="search terms")
    p.add_argument("-n", "--limit", type=int, default=8)
    p.add_argument("--toolkit", type=Path, default=None)
    p.add_argument("--json", action="store_true", help="JSON output")
    args = p.parse_args()

    root = args.toolkit or default_toolkit()
    index_path = root / "index.json"
    if not index_path.is_file():
        print(f"ERROR: index not found at {index_path}", file=sys.stderr)
        print("Run grok-cyber-skills install.ps1 / install.sh first.", file=sys.stderr)
        return 2

    data = json.loads(index_path.read_text(encoding="utf-8"))
    skills = data.get("skills") or []
    tokens = tokenize(" ".join(args.query))
    if not tokens:
        print("ERROR: empty query", file=sys.stderr)
        return 2

    ranked = []
    for sk in skills:
        sc = score_skill(sk, tokens)
        if sc > 0:
            ranked.append((sc, sk))
    ranked.sort(key=lambda x: (-x[0], x[1].get("name", "")))
    top = ranked[: max(1, args.limit)]

    if args.json:
        out = [
            {
                "score": sc,
                "name": sk.get("name"),
                "description": sk.get("description"),
                "path": sk.get("path"),
                "skill_md": str(root / sk.get("path", "") / "SKILL.md"),
            }
            for sc, sk in top
        ]
        print(json.dumps({"toolkit": str(root), "total": len(skills), "hits": out}, indent=2))
        return 0

    print(f"toolkit: {root}")
    print(f"index skills: {len(skills)} | query: {' '.join(tokens)} | showing {len(top)}")
    print("-" * 72)
    for i, (sc, sk) in enumerate(top, 1):
        name = sk.get("name", "?")
        desc = (sk.get("description") or "").replace("\n", " ").strip()
        if len(desc) > 100:
            desc = desc[:97] + "..."
        path = sk.get("path", "")
        print(f"{i:2}. [{sc:.1f}] {name}")
        print(f"    {desc}")
        print(f"    {root / path / 'SKILL.md'}")
    if not top:
        print("No matches.")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
