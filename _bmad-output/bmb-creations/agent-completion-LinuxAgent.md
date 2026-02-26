# Agent Creation Complete! 🎉

## Agent Summary

- **Name:** Carter
- **Title:** Linux System Advisor
- **Icon:** 🐧
- **Type:** Expert Agent (with sidecar)
- **Purpose:** Proactive Arch Linux companion — monitoring, advising, and improving Maxime's system
- **Status:** Ready for installation

## File Locations

- **Agent Config:** `_bmad-output/bmb-creations/linux-agent/linux-agent.agent.yaml`
- **Sidecar — Memories:** `_bmad-output/bmb-creations/linux-agent/linux-agent-sidecar/memories.md`
- **Sidecar — Instructions:** `_bmad-output/bmb-creations/linux-agent/linux-agent-sidecar/instructions.md`
- **Agent Plan:** `_bmad-output/bmb-creations/agent-plan-LinuxAgent.md`

## Commands

| Trigger | Description |
|---------|-------------|
| `DB` | Daily system briefing — updates, health, highlights |
| `SH` | Full system health snapshot |
| `PU` | Check pending package updates (pacman + AUR) |
| `SC` | Arch Linux security advisories check |
| `NH` | Neovim plugin & LSP health audit |
| `RI` | Rice ideas & community inspiration 🎨 |
| `SM` | Stow package management & symlink check |
| `CL` | System cleanup recommendations |
| `SS` | Save session state to memory |

## Installation

Package your agent as a standalone BMAD module with a `module.yaml` file.

### Module Structure

```
my-custom-stuff/
├── module.yaml
└── agents/
    └── linux-agent/
        ├── linux-agent.agent.yaml
        └── linux-agent-sidecar/
            ├── memories.md
            └── instructions.md
```

### module.yaml Example

```yaml
code: my-custom-stuff
name: My Custom Agents
version: 1.0.0
```

See full guide: https://github.com/bmad-code-org/BMAD-METHOD/blob/main/docs/modules/bmb-bmad-builder/custom-content-installation.md#standalone-content-agents-workflows-tasks-tools-templates-prompts

## Quick Start

1. Create a module folder (e.g. `my-custom-stuff/`)
2. Add `module.yaml` with `code`, `name`, `version`
3. Copy the entire `linux-agent/` folder into `agents/`
4. Install via BMAD installer (new project) or "Modify BMAD Installation" (existing project)
5. Activate Carter and say hi! 🐧
