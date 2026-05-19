# Healthcheck Runbook

Run `scripts/healthcheck.ps1` on Windows or `scripts/healthcheck.sh` from Git Bash/Linux/macOS.

Expected checks:
- `hermes-gateway.service` is active;
- `hermes-gateway.service` is enabled;
- `/srv/hermes/workspace` exists;
- Hermes version is shown if available;
- environment secret names are detected without printing values.

If the service is inactive, inspect `systemctl status hermes-gateway.service` and `journalctl -u hermes-gateway.service -n 100 --no-pager` on the VDS. Review logs for secrets before adding anything to Git.
