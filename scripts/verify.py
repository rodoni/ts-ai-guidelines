#!/usr/bin/env python3
"""
TypeScript AI Guidelines Verification Suite
Audits rule consistency, structure, link integrity, and deployment across all targets.
"""

import os
import sys
import glob
import re
import tempfile
import subprocess

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

errors = []

def error(msg: str):
    errors.append(msg)
    print(f"\033[1;31m[FAIL]\033[0m {msg}")

def success(msg: str):
    print(f"\033[1;32m[PASS]\033[0m {msg}")

def check_rules_structure():
    print("\n--- 1. Checking Atomic Rules Structure ---")
    rule_files = glob.glob(os.path.join(REPO_ROOT, "rules", "*.md"))
    if not rule_files:
        error("No rule files found in rules/")
        return

    required_sections = ["## Why It Matters", "## Bad", "## Good"]

    for rf in rule_files:
        basename = os.path.splitext(os.path.basename(rf))[0]
        with open(rf, "r", encoding="utf-8") as f:
            content = f.read()

        lines = content.strip().splitlines()
        if not lines or not lines[0].startswith(f"# {basename}"):
            error(f"{rf}: First line must be '# {basename}'")

        if not any(line.strip().startswith(">") for line in lines[:5]):
            error(f"{rf}: Missing blockquote imperative '> ...' near the top")

        for sec in required_sections:
            if sec not in content:
                error(f"{rf}: Missing required section '{sec}'")

    success(f"Validated structure of {len(rule_files)} atomic rules.")

def check_rule_references():
    print("\n--- 2. Checking Rule Reference Integrity ---")
    rules_on_disk = {
        os.path.splitext(os.path.basename(f))[0]
        for f in glob.glob(os.path.join(REPO_ROOT, "rules", "*.md"))
    }

    # Check README
    readme_path = os.path.join(REPO_ROOT, "README.md")
    if os.path.exists(readme_path):
        with open(readme_path, "r", encoding="utf-8") as f:
            readme_text = f.read()

        readme_rules = set(re.findall(r'`([a-z0-9-]+)`', readme_text))
        non_rule_ids = {
            "vue-guidelines", "vue-testing", "vue-architect", "vue-test-engineer",
            "pinia-guidelines", "pinia-testing", "pinia-architect", "pinia-test-engineer",
        }
        readme_rule_candidates = {
            r for r in readme_rules
            if r.startswith(("t-", "c-", "perf-", "m-", "wf-", "test-", "vue-", "pinia-"))
            and r not in non_rule_ids
        }
        missing_from_readme = readme_rule_candidates - rules_on_disk
        if missing_from_readme:
            error(f"README.md references non-existent rules: {missing_from_readme}")
        else:
            success("All rules referenced in README.md exist in rules/.")

    # Check Agents
    agent_files = glob.glob(os.path.join(REPO_ROOT, "agents", "*.md"))
    agent_errors = len(errors)
    for af in agent_files:
        with open(af, "r", encoding="utf-8") as f:
            text = f.read()
        tokens = set(re.findall(r'`([a-z0-9-]+)`', text))
        candidates = {r for r in tokens if r.startswith(("t-", "c-", "perf-", "m-", "wf-", "test-", "vue-", "pinia-"))}
        missing = candidates - rules_on_disk
        if missing:
            error(f"{af} references non-existent rules: {missing}")

    if len(errors) == agent_errors:
        success(f"Validated rule references across {len(agent_files)} agent specifications.")

    # Check Master Skill Index
    master_skill = os.path.join(REPO_ROOT, "skills", "ts-guidelines", "SKILL.md")
    with open(master_skill, "r", encoding="utf-8") as f:
        master_text = f.read()

    indexed_rules = set(re.findall(r'\[`([a-z0-9-]+)`\]\(', master_text))
    unindexed = rules_on_disk - indexed_rules
    if unindexed:
        error(f"Master skill ts-guidelines/SKILL.md is missing index for: {unindexed}")
    else:
        success("All atomic rules are indexed in master skill ts-guidelines/SKILL.md.")

def check_skill_frontmatter():
    print("\n--- 2b. Checking Skill Frontmatter ---")
    skill_files = glob.glob(os.path.join(REPO_ROOT, "skills", "**", "SKILL.md"), recursive=True)
    skill_errors = len(errors)
    required_fields = {
        "name": re.compile(r"^name:\s+\S+", re.MULTILINE),
        "description": re.compile(r"^description:\s*>\s*$", re.MULTILINE),
        "license": re.compile(r"^license:\s+\S+", re.MULTILINE),
        "metadata": re.compile(r"^metadata:\s*$", re.MULTILINE),
    }

    for skill_file in skill_files:
        with open(skill_file, "r", encoding="utf-8") as f:
            content = f.read()
        if not content.startswith("---\n") or "\n---\n" not in content[4:]:
            error(f"{skill_file}: Missing YAML frontmatter delimiters")
            continue
        for field, pattern in required_fields.items():
            if not pattern.search(content):
                error(f"{skill_file}: Missing or invalid frontmatter field '{field}'")

    if len(errors) == skill_errors:
        success(f"Validated frontmatter for {len(skill_files)} skills.")

def check_markdown_links():
    print("\n--- 3. Checking Relative Markdown Links ---")
    checked_files = 0
    broken_links = 0

    all_md_files = (
        [os.path.join(REPO_ROOT, "README.md")]
        + glob.glob(os.path.join(REPO_ROOT, "rules", "*.md"))
        + glob.glob(os.path.join(REPO_ROOT, "skills", "**", "*.md"), recursive=True)
        + glob.glob(os.path.join(REPO_ROOT, "agents", "*.md"))
        + glob.glob(os.path.join(REPO_ROOT, "targets", "**", "*.md"), recursive=True)
    )

    for md_file in all_md_files:
        checked_files += 1
        dir_path = os.path.dirname(md_file)
        with open(md_file, "r", encoding="utf-8") as f:
            content = f.read()

        # Find markdown links: [text](path)
        links = re.findall(r'\[.*?\]\((?!https?://|mailto:|#)(.*?)\)', content)
        for link in links:
            # Strip anchors
            clean_link = link.split("#")[0].strip()
            if not clean_link:
                continue
            resolved_path = os.path.normpath(os.path.join(dir_path, clean_link))
            if not os.path.exists(resolved_path):
                error(f"{md_file}: Broken relative link '{link}' -> resolved to '{resolved_path}'")
                broken_links += 1

    if broken_links == 0:
        success(f"Validated all relative links across {checked_files} markdown files.")

def check_deployment_targets():
    print("\n--- 4. Checking Multi-Target Deployment Synchronization ---")
    targets = ["antigravity", "opencode", "kilocode", "cursor", "claude", "copilot"]

    for target in targets:
        target_errors = len(errors)
        with tempfile.TemporaryDirectory() as tmpdir:
            cmd = [os.path.join(REPO_ROOT, "sync.sh"), target, tmpdir]
            res = subprocess.run(cmd, capture_output=True, text=True)
            if res.returncode != 0:
                error(f"sync.sh failed for target '{target}': {res.stderr}")
                continue

            # Check target-specific file presence and complete generated trees.
            if target == "antigravity":
                expected = os.path.join(tmpdir, ".agents", "AGENTS.md")
                expected_rules = glob.glob(os.path.join(tmpdir, ".agents", "rules", "*.md"))
                expected_skills = glob.glob(os.path.join(tmpdir, ".agents", "skills", "**", "*.md"), recursive=True)
                expected_agents = glob.glob(os.path.join(tmpdir, ".agents", "agents", "*.md"))
            elif target == "opencode":
                expected = os.path.join(tmpdir, ".opencode", "AGENTS.md")
                expected_rules = glob.glob(os.path.join(tmpdir, ".opencode", "rules", "*.md"))
                expected_skills = glob.glob(os.path.join(tmpdir, ".opencode", "skills", "**", "*.md"), recursive=True)
                expected_agents = glob.glob(os.path.join(tmpdir, ".opencode", "agents", "*.md"))
            elif target == "kilocode":
                expected = os.path.join(tmpdir, ".kilo", "kilo.jsonc")
                expected_rules = glob.glob(os.path.join(tmpdir, ".kilo", "rules", "*.md"))
                expected_skills = glob.glob(os.path.join(tmpdir, ".kilo", "skills", "**", "*.md"), recursive=True)
                expected_agents = glob.glob(os.path.join(tmpdir, ".kilo", "agents", "*.md"))
            elif target == "cursor":
                expected_rules = glob.glob(os.path.join(tmpdir, ".cursor", "rules", "*.mdc"))
                if len(expected_rules) != len(glob.glob(os.path.join(REPO_ROOT, "rules", "*.md"))):
                    error(f"Target 'cursor' deployed {len(expected_rules)} of the expected rules in {tmpdir}")
                expected = os.path.join(tmpdir, ".cursor", "rules")
                expected_skills = glob.glob(os.path.join(tmpdir, ".cursor", "skills", "**", "*.md"), recursive=True)
                expected_agents = glob.glob(os.path.join(tmpdir, ".cursor", "agents", "*.md"))
            elif target == "claude":
                expected = os.path.join(tmpdir, "CLAUDE.md")
                expected_rules = glob.glob(os.path.join(tmpdir, ".claude", "rules", "*.md"))
                expected_skills = glob.glob(os.path.join(tmpdir, ".claude", "skills", "**", "*.md"), recursive=True)
                expected_agents = glob.glob(os.path.join(tmpdir, ".claude", "agents", "*.md"))
            elif target == "copilot":
                expected = os.path.join(tmpdir, ".github", "copilot-instructions.md")

            if not os.path.exists(expected):
                error(f"Target '{target}' missing expected output file: {expected}")
            else:
                if target != "copilot":
                    if target != "cursor" and len(expected_rules) != len(glob.glob(os.path.join(REPO_ROOT, "rules", "*.md"))):
                        error(f"Target '{target}' deployed an incomplete rules tree.")
                    if len(expected_skills) < len(glob.glob(os.path.join(REPO_ROOT, "skills", "**", "*.md"), recursive=True)):
                        error(f"Target '{target}' deployed an incomplete skills tree.")
                    if len(expected_agents) != len(glob.glob(os.path.join(REPO_ROOT, "agents", "*.md"))):
                        error(f"Target '{target}' deployed an incomplete agents tree.")
                if len(errors) == target_errors:
                    success(f"Target '{target}' deployed and validated successfully.")

def main():
    print("=" * 60)
    print(" TypeScript AI Guidelines & Agentic Tools Verification Suite")
    print("=" * 60)

    check_rules_structure()
    check_rule_references()
    check_skill_frontmatter()
    check_markdown_links()
    check_deployment_targets()

    print("\n" + "=" * 60)
    if errors:
        print(f"\033[1;31m[FAILED]\033[0m Verification finished with {len(errors)} error(s).")
        sys.exit(1)
    else:
        print("\033[1;32m[PASSED]\033[0m All TypeScript AI guidelines verification tests passed cleanly!")
        sys.exit(0)

if __name__ == "__main__":
    main()
