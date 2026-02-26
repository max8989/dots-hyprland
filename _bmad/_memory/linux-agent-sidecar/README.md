# linux-agent-sidecar

This folder stores persistent memory for the **Carter** (Linux System Advisor) agent.

## Purpose

Enables Carter to remember things across sessions: dismissed alerts, user preferences,
system baselines, session history, and accumulated knowledge about Maxime's Arch/Hyprland
setup — so every interaction feels like talking to a companion who knows your system.

## Files

- `memories.md` — User profile, session history, preferences, dismissed alerts
- `instructions.md` — Operational protocols, behavioral rules, startup sequence

## Runtime Access

After BMAD installation, this folder will be accessible at:
`{project-root}/_bmad/_memory/linux-agent-sidecar/`

## Usage

Carter reads these files on every activation via `critical_actions`.
Use the **[SS] Save session** menu command to update memories after each session.
