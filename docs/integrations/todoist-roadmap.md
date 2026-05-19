# Todoist Integration Roadmap

## Why

Todoist can let Hermes capture tasks, review plans, add reminders, and organize personal execution from Telegram.

## Credentials

Needed: Todoist API token or OAuth credentials, plus project IDs and label conventions. Store secrets only on the VDS secret location, not in Git.

## Hermes Skills/Tools

Useful tools: list projects, list tasks, create task, update task, complete task with confirmation, daily or weekly planning summaries.

## Read Data

Projects, active tasks, labels, due dates, and comments if needed after approval.

## Mutate Data

Creating ambiguous tasks, completing tasks, deleting tasks, changing due dates, and bulk edits require confirmation.

## Verification

Read the project list. Create one test task in a sandbox project after confirmation. Confirm no token appears in logs or repo. Document scopes and test result.

## Risks

Duplicate tasks, overwritten due dates, personal task data leaking into snapshots, and treating natural language guesses as confirmed commitments.
