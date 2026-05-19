# Multi-Agent Roadmap

Goal: evolve Hermes from one Telegram assistant into a personal multi-agent system.

Core idea: the main personal assistant receives a Telegram request, determines the task type, delegates to a specialized agent or skill, reviews the result, and replies to the user.

## Stage 1: One Strong Hermes Agent

Run one main Hermes agent with good memory, workspace organization, and rules. Make the single-agent loop reliable before adding routing complexity.

## Stage 2: Specialized Skills

Add focused skills for copywriting, planning, research, summarization, and project organization. Each skill needs input requirements, an output contract, and quality criteria.

## Stage 3: Delegation/Subagents

For complex work, the main assistant delegates bounded tasks to subagents: research, drafting, implementation, or verification. The main assistant keeps ownership of final quality and user-facing response.

## Stage 4: Integrations

Add Notion, Todoist, Google Workspace, CRM, and other tools. Each integration must define credentials, scopes, secret storage, read/write boundaries, confirmation rules, and verification.

## Stage 5: Separate Roles

Use an orchestrator-worker approach with roles such as copywriter, planner, researcher, operator, and integrator. The orchestrator routes, workers return structured outputs, and the orchestrator validates.

## Stage 6: Separate Instances Or Services

Use separate Hermes instances or services only when real isolation is needed: different credentials, security boundaries, reliability requirements, resource limits, or independent deployment cycles.

## Routing Principles

Route by user intent, required tools, risk, and output type. Ask for confirmation before external writes, credential changes, purchases, messages, deletions, or bulk edits. Keep credentials outside Git.
