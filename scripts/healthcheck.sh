#!/usr/bin/env bash
set -euo pipefail
HOST="${HERMES_VDS_HOST:-78.17.192.180}"
USER="${HERMES_VDS_USER:-root}"
PORT="${HERMES_VDS_PORT:-22}"
KEY="${HERMES_VDS_KEY:-$HOME/.ssh/hermes-vds/78.17.192.180_ed25519}"
ssh -o BatchMode=yes -o ConnectTimeout=15 -i "$KEY" -p "$PORT" "$USER@$HOST" bash -s <<'REMOTE'
echo "service.active=$(systemctl is-active hermes-gateway.service 2>/dev/null || true)"
echo "service.enabled=$(systemctl is-enabled hermes-gateway.service 2>/dev/null || true)"
test -d /srv/hermes/workspace && echo "workspace.exists=yes" || echo "workspace.exists=no"
(command -v hermes >/dev/null 2>&1 && hermes --version) || echo "hermes.version=unknown"
if test -f /home/hermes/.hermes/.env; then
  names=$(grep -E 'TOKEN|KEY|SECRET|PASSWORD' /home/hermes/.hermes/.env 2>/dev/null | sed 's/=.*$/=<redacted>/')
  if test -n "$names"; then echo "env.secret_names_present=yes"; else echo "env.secret_names_present=no"; fi
else
  echo "env.file_present=no"
fi
REMOTE
