$ErrorActionPreference = "Stop"
$HostName = $env:HERMES_VDS_HOST; if (-not $HostName) { $HostName = "78.17.192.180" }
$User = $env:HERMES_VDS_USER; if (-not $User) { $User = "root" }
$Port = $env:HERMES_VDS_PORT; if (-not $Port) { $Port = "22" }
$Key = $env:HERMES_VDS_KEY; if (-not $Key) { $Key = Join-Path $HOME ".ssh\hermes-vds\78.17.192.180_ed25519" }
$remote = @(
  'echo "service.active=$(systemctl is-active hermes-gateway.service 2>/dev/null || true)"',
  'echo "service.enabled=$(systemctl is-enabled hermes-gateway.service 2>/dev/null || true)"',
  'test -d /srv/hermes/workspace && echo "workspace.exists=yes" || echo "workspace.exists=no"',
  '(command -v hermes >/dev/null 2>&1 && hermes --version) || echo "hermes.version=unknown"',
  'if test -f /home/hermes/.hermes/.env; then names=$(grep -E "TOKEN|KEY|SECRET|PASSWORD" /home/hermes/.hermes/.env 2>/dev/null | sed "s/=.*$/=<redacted>/"); if test -n "$names"; then echo "env.secret_names_present=yes"; else echo "env.secret_names_present=no"; fi; else echo "env.file_present=no"; fi'
) -join "`n"
$b64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($remote))
$cmd = "printf '%s' '$b64' | base64 -d | bash"
ssh -o BatchMode=yes -o ConnectTimeout=15 -i "$Key" -p $Port "$User@$HostName" $cmd