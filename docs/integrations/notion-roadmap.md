# Notion Integration Roadmap

## Why

Notion can provide structured long-term knowledge: projects, notes, CRM-like tables, content plans, and decision records.

## Credentials

Needed: Notion integration token, database/page IDs, and approved workspace access. Store secrets only on the VDS secret location, not in Git.

## Hermes Skills/Tools

Useful tools: page search, database query, page creation, page update with confirmation, summarization into workspace docs.

## Read Data

Selected pages, selected databases, project notes, and content calendars after approval.

## Mutate Data

Creating pages, editing pages, changing database records, archiving/deleting content, and bulk updates require confirmation.

## Verification

Query a test page or database. Create a test page only after confirmation. Confirm no token appears in logs or repo. Document scopes and test result.

## Risks

Overbroad permissions, accidental edits, secret leakage in logs, and treating stale Notion data as current truth.
