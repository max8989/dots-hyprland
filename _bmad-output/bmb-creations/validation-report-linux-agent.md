---
agentName: 'linux-agent'
hasSidecar: true
module: 'stand-alone'
agentFile: '_bmad-output/bmb-creations/linux-agent/linux-agent.agent.yaml'
validationDate: '2026-02-25'
stepsCompleted:
  - v-01-load-review.md
  - v-02a-validate-metadata.md
  - v-02b-validate-persona.md
  - v-02c-validate-menu.md
  - v-02d-validate-structure.md
  - v-02e-validate-sidecar.md
  - v-03-summary.md
overallStatus: PASS
---

# Validation Report: linux-agent (Carter)

## Agent Overview

**Name:** Carter
**Title:** Linux System Advisor
**Icon:** 🐧
**hasSidecar:** true
**module:** stand-alone
**File:** `_bmad-output/bmb-creations/linux-agent/linux-agent.agent.yaml`

---

## Overall Status

| Section | Status |
|---------|--------|
| Metadata | ✅ PASS |
| Persona | ✅ PASS |
| Menu | ✅ PASS |
| Structure | ✅ PASS |
| Sidecar | ✅ PASS |
| **Overall** | **✅ PASS — READY FOR INSTALLATION** |

---

## Validation Findings

### Metadata Validation

**Status:** ✅ PASS

**Checks:**
- [x] id: `_bmad/agents/linux-agent/linux-agent.md` — kebab-case, unique
- [x] name: `Carter` — clear display name, not a duplicate of title
- [x] title: `Linux System Advisor` — concise function description
- [x] icon: `🐧` — single emoji, visually representative
- [x] module: `stand-alone` — correct format
- [x] hasSidecar: `true` — matches actual agent structure
- [x] sidecar-folder: `linux-agent-sidecar` — present as required

*PASSING:* All 7 metadata fields valid. No name/title duplication. ID path consistent with filename.

*WARNINGS:* None

*FAILURES:* None

---

### Persona Validation

**Status:** ✅ PASS

**Checks:**
- [x] role: Specific, first-person, covers Arch/Hyprland/Neovim/Stow domains
- [x] identity: Character defined, community-embedded, includes sidecar memory reference patterns
- [x] communication_style: Speech patterns only — enthusiasm, emoji, casual directness
- [x] principles: 6 principles, first activates domain knowledge, all belief-framed not task-framed

*PASSING:* Four-field purity maintained. Role ≠ identity ≠ communication_style ≠ principles. First principle correctly activates Arch Linux sysadmin expertise. Memory reference patterns included in identity for sidecar agent.

*WARNINGS:* None

*FAILURES:* None

---

### Menu Validation

**Status:** ✅ PASS

**hasSidecar:** true

**Checks:**
- [x] Triggers follow `XX or fuzzy match on command` format — all 9 items
- [x] Descriptions start with `[XX]` code — all 9 items
- [x] No reserved codes (MH, CH, PM, DA) — clean
- [x] All action handlers `#prompt-id` reference existing prompts — 9/9 verified
- [x] Trigger codes unique — DB, SH, PU, SC, NH, RI, SM, CL, SS all distinct
- [x] Menu scope appropriate — 9 commands covering all defined capabilities

*PASSING:* All menu items valid. Full prompt ID cross-reference verified. No reserved codes used.

*WARNINGS:* None

*FAILURES:* None

---

### Structure Validation

**Status:** ✅ PASS

**Configuration:** Agent WITH sidecar

**hasSidecar:** true

**Checks:**
- [x] Valid YAML syntax — no parse errors
- [x] 2-space indentation consistent throughout
- [x] No duplicate keys in any section
- [x] All required sections present: metadata, persona, critical_actions, prompts, menu
- [x] hasSidecar: true — sidecar-folder and sidecar-path in metadata
- [x] critical_actions present — 6 actions (3 mandatory + 3 proactive)
- [x] All critical_actions use `{project-root}/_bmad/_memory/linux-agent-sidecar/` paths
- [x] No compiler-injected content (no frontmatter, XML, MH/CH/PM/DA items)
- [x] 9 unique prompt IDs

*PASSING:* Full structural compliance. Clean YAML ready for BMAD compiler.

*WARNINGS:* None

*FAILURES:* None

---

### Sidecar Validation

**Status:** ✅ PASS

**hasSidecar:** true

**Checks:**
- [x] Sidecar folder naming: `linux-agent-sidecar` — follows `{agent-name}-sidecar` convention
- [x] `memories.md` present and initialized with user profile template
- [x] `instructions.md` present with full operational protocols
- [x] `README.md` present (documentation bonus)
- [x] Path format correct: `{project-root}/_bmad/_memory/linux-agent-sidecar/`
- [x] `{project-root}` kept as literal throughout
- [x] Mandatory critical_actions present (load memories, load instructions, restrict access)
- [x] No placeholder text in critical_actions
- [x] No orphaned references

*PASSING:* Sidecar fully compliant. All files present. Path references correct. Critical actions complete.

*WARNINGS:* None

*FAILURES:* None
