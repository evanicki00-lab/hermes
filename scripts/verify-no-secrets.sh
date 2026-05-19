#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
if find . -path ./.git -prune -o -name auth.json -print | grep -q .; then echo "Forbidden auth.json file found." >&2; exit 1; fi
if grep -RInE --exclude-dir=.git --exclude='verify-no-secrets.sh' --exclude='verify-no-secrets.ps1' --exclude='README.md' --exclude='AGENTS.md' --exclude='update-telegram-token.md' 'TELEGRAM_BOT_TOKEN|[0-9]{8,12}:[A-Za-z0-9_-]{30,}|auth\.json|OPENAI_API_KEY|sk-[A-Za-z0-9_-]{20,}|BEGIN (OPENSSH|RSA|EC|DSA) PRIVATE KEY|(^|/)\.env(\.|$|/)|(password|passwd|secret|api[_-]?key|token)[[:space:]]*[:=][[:space:]]*[^[:space:]<]+' .; then
  echo "Potential secrets found." >&2
  exit 1
fi
echo "No obvious secrets found."
