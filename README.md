# Hermes Personal Agent Ops Repo

This is not the Hermes source code. This is a private operations and project repository for the existing Hermes personal agent running on the VDS.

It tracks safe project context, architecture, runbooks, sanitized snapshots, and roadmap decisions for future Codex/Claude work.

## Defaults

- VDS host: `78.17.192.180`
- SSH user: `root`
- SSH port: `22`
- Hermes user: `hermes`
- Hermes home: `/home/hermes/.hermes`
- Hermes workspace: `/srv/hermes/workspace`
- Gateway service: `hermes-gateway.service`

## Sync From VDS

Windows PowerShell:

```powershell
.\scripts\sync-from-vds.ps1
```

Git Bash/Linux/macOS:

```bash
bash scripts/sync-from-vds.sh
```

The sync scripts copy safe snapshots and exclude secrets, auth files, databases, caches, sessions, and logs.

## Healthcheck

```powershell
.\scripts\healthcheck.ps1
```

or:

```bash
bash scripts/healthcheck.sh
```

## Safety

Never commit Telegram bot tokens, OAuth tokens, SSH private keys, root passwords, `.env`, `auth.json`, cookies, sessions, logs, runtime databases, or API keys.

Before every commit run:

```powershell
.\scripts\verify-no-secrets.ps1
```

## Continuing With Codex/Claude

Read `AGENTS.md`, `docs/current-state.md`, and the relevant runbook. Document any intentional VDS change in this repo. Real integrations require separate confirmation before credentials or write access are configured.

## Next Steps

- Keep snapshots current with `scripts/sync-from-vds.*`.
- Expand multi-agent routing before implementing delegation.
- Prepare copywriting context in Hermes workspace before enabling a copywriter agent.
- Add Notion/Todoist credentials only after separate confirmation.
