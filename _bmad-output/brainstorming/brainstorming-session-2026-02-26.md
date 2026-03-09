---
stepsCompleted: [1, 2, 3]
inputDocuments: []
session_topic: 'Agentic AI Tooling Advisor Agent'
session_goals: 'Define name/personality, core capabilities, BMAD integration, standalone mode, catalogue repo design, model research'
selected_approach: 'ai-recommended'
techniques_used: ['First Principles Thinking', 'SCAMPER (partial)']
ideas_generated: 5
context_file: '_bmad/bmb/workflows/agent/data/brainstorm-context.md'
---

# Brainstorming Session Results

**Facilitator:** Maxime
**Date:** 2026-02-26

## Session Overview

**Topic:** Agentic AI Tooling Advisor Agent
**Goals:** Name & personality, core vs. nice-to-have capabilities, BMAD integration vs. standalone modes, catalogue repo design, model research capability

### Context Guidance

Scoped to the four pillars: Identity (WHO), Voice (HOW), Purpose (WHAT), Architecture (TYPE). Mission: create an agent so vivid and useful that users seek it out by name.

---

## Technique Execution Results

### Technique 1: First Principles Thinking

**Interactive Focus:** Stripping "recommend" down to its real primitive — what does useful, trustworthy, on-demand tooling advice actually look like?

**Core Truths Established (Bedrock):**

**[Identity #1]**: On-Demand Oracle
_Concept_: The agent is invoked by the user, not proactive. Like a senior consultant you call in — not a background daemon. You're in control of when it speaks.
_Novelty_: Most tool advisors are passive scanners or notification systems. This one respects the user's agency and only activates on explicit request.

**[Identity #2]**: Curiosity-Driven Explorer
_Concept_: The trigger moment is curiosity, not pain. The user isn't broken — they're in explorer mode, wondering if their current setup could be smarter. The agent should feel like a knowledgeable friend who just got back from a conference.
_Novelty_: Shifts the agent's tone from "doctor diagnosing problems" to "excited peer sharing discoveries tailored to your world."

**[Identity #3]**: Personalized Delta Engine
_Concept_: The agent knows your stack, your project history, your patterns — and it knows the ecosystem's evolution. It surfaces the gap between "how you're solving it today" and "what's possible now."
_Novelty_: Not generic recommendations — always grounded in the user's actual project and prior work. "You're reinventing a wheel that now has a name, a package, and an MCP."

**[Identity #4]**: Project-Grounded Advisor
_Concept_: Every recommendation is anchored to the user's actual codebase, not abstract best practices. It reads the project and speaks in terms of what's already there.
_Novelty_: Eliminates the gap between "here's what you should use" and "here's how it applies to your specific situation."

**[Identity #5]**: Context + Instant Value Delivery
_Concept_: Every recommendation comes with two things — WHY it matters for the user right now (context) and immediate scaffolding/setup (instant value). Not an advisor, not a search engine — a knowledgeable friend who also does the work.
_Novelty_: The curiosity-mode user needs to go from "huh interesting" to "okay set it up" in one exchange. Context makes you care, instant value makes you act.

**Creative Breakthrough:** The core primitive is not "recommend tools" — it's an **awareness engine** that surfaces the delta between your current approach and what the ecosystem now makes possible, delivered on demand with immediate actionability.

---

### Technique 2: SCAMPER (Partial — S lens explored)

**[Capability #6]**: Agentic Workflow Scanner
_Concept_: Instead of scanning project files, scan conversation history with other agents (Architect, dev, etc.) to find patterns where a skill or MCP would eliminate repetitive manual work the user keeps asking agents to do.
_Novelty_: Finds gaps not in code but in the agentic workflow itself — a meta-layer most tools completely miss.

**Energy:** High engagement during First Principles. User signaled satisfactory depth after S-lens of SCAMPER — good signal that the core concept is now clear enough to move to agent design.

---

## Key Insights Summary

1. **It's a curiosity tool, not a diagnostic tool** — tone and UX must reflect this
2. **On-demand is a feature, not a limitation** — respect user agency
3. **Context + instant value is the trust mechanism** — not accuracy alone
4. **It has memory** — across projects, across time
5. **It can watch agentic workflows too** — not just codebases
6. **It lives in BMAD but thinks beyond it** — catalogue repo as the living output
