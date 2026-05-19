# Agent Instructions

This repository is a private ops/project repo for an already installed Hermes Agent on a VDS. It is not the Hermes source tree.

Rules:
- Never print or commit secrets: Telegram tokens, OAuth tokens, API keys, SSH private keys, root passwords, `.env`, `auth.json`, cookies, sessions, logs, `state.db`, or `kanban.db`.
- Treat VDS mutations as production operations and ask for confirmation before changing services, credentials, integrations, firewall, SSH policy, or runtime config.
- Read-only healthchecks and safe snapshot sync are normal maintenance.
- Document every intentional VDS change in this repo.
- Run `scripts/verify-no-secrets.*` before every commit.
- New integrations require separate confirmation and must document scopes, secret storage, risks, and rollback.

Known defaults:
- SSH: `root@78.17.192.180:22`
- Hermes home: `/home/hermes/.hermes`
- Workspace: `/srv/hermes/workspace`
- Service: `hermes-gateway.service`
