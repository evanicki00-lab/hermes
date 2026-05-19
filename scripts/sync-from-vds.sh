#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOST="${HERMES_VDS_HOST:-78.17.192.180}"
USER="${HERMES_VDS_USER:-root}"
PORT="${HERMES_VDS_PORT:-22}"
KEY="${HERMES_VDS_KEY:-$HOME/.ssh/hermes-vds/78.17.192.180_ed25519}"
SSH=(ssh -o BatchMode=yes -o ConnectTimeout=15 -i "$KEY" -p "$PORT" "$USER@$HOST")
rm -rf "$ROOT/snapshots/workspace"
mkdir -p "$ROOT/snapshots/workspace" "$ROOT/snapshots/hermes/memories" "$ROOT/snapshots/systemd"
"${SSH[@]}" "tar -czf - --exclude='.env' --exclude='.env.*' --exclude='auth.json' --exclude='*.lock' --exclude='*.pid' --exclude='state.db*' --exclude='kanban.db' --exclude='sessions' --exclude='logs' --exclude='cache' --exclude='audio_cache' --exclude='image_cache' -C /srv/hermes/workspace . 2>/dev/null" | tar -xzf - -C "$ROOT/snapshots/workspace"
scp -q -i "$KEY" -P "$PORT" "$USER@$HOST:/home/hermes/.hermes/SOUL.md" "$ROOT/snapshots/hermes/SOUL.md" 2>/dev/null || true
scp -q -i "$KEY" -P "$PORT" "$USER@$HOST:/home/hermes/.hermes/memories/MEMORY.md" "$ROOT/snapshots/hermes/memories/MEMORY.md" 2>/dev/null || true
scp -q -i "$KEY" -P "$PORT" "$USER@$HOST:/home/hermes/.hermes/memories/USER.md" "$ROOT/snapshots/hermes/memories/USER.md" 2>/dev/null || true
"${SSH[@]}" "if test -f /home/hermes/.hermes/config.yaml; then sed -E 's/(token|api_key|apikey|secret|password|authorization):.*/\1: <redacted>/Ig' /home/hermes/.hermes/config.yaml; fi" > "$ROOT/snapshots/hermes/config.sanitized.yaml"
"${SSH[@]}" "systemctl cat hermes-gateway.service 2>/dev/null || true" > "$ROOT/snapshots/systemd/hermes-gateway.service"
"${SSH[@]}" "find /home/hermes/.hermes -maxdepth 3 -type d \( -iname skills -o -iname skill \) -print 2>/dev/null; find /home/hermes/.hermes/skills -maxdepth 2 -type f -name 'SKILL.md' -print 2>/dev/null" > "$ROOT/snapshots/hermes/skills.txt"
"${SSH[@]}" "echo synced_at=\$(date -Iseconds); echo service_active=\$(systemctl is-active hermes-gateway.service 2>/dev/null || true); echo service_enabled=\$(systemctl is-enabled hermes-gateway.service 2>/dev/null || true); echo workspace_exists=\$(test -d /srv/hermes/workspace && echo yes || echo no); echo hermes_home_exists=\$(test -d /home/hermes/.hermes && echo yes || echo no)" > "$ROOT/snapshots/healthcheck.txt"
