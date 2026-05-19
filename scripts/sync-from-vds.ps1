$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$HostName = $env:HERMES_VDS_HOST; if (-not $HostName) { $HostName = "78.17.192.180" }
$User = $env:HERMES_VDS_USER; if (-not $User) { $User = "root" }
$Port = $env:HERMES_VDS_PORT; if (-not $Port) { $Port = "22" }
$Key = $env:HERMES_VDS_KEY; if (-not $Key) { $Key = Join-Path $HOME ".ssh\hermes-vds\78.17.192.180_ed25519" }
function Remote($script) {
  $b64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($script))
  $cmd = "printf '%s' '$b64' | base64 -d | bash"
  ssh -o BatchMode=yes -o ConnectTimeout=15 -i "$Key" -p $Port "$User@$HostName" $cmd
}
function PullFile($remotePath, $localPath) {
  $dir = Split-Path -Parent $localPath
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  scp -q -i "$Key" -P $Port ("${User}@${HostName}:$remotePath") "$localPath" 2>$null
  if ($LASTEXITCODE -ne 0) { Write-Output "missing: $remotePath" }
}
Remove-Item -Recurse -Force (Join-Path $RepoRoot "snapshots\workspace") -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path (Join-Path $RepoRoot "snapshots\workspace") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $RepoRoot "snapshots\hermes\memories") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $RepoRoot "snapshots\systemd") | Out-Null
$tmp = Join-Path $env:TEMP "hermes-workspace-snapshot.tar.gz"
$remoteTmp = "/tmp/hermes-workspace-snapshot-$([guid]::NewGuid().ToString()).tar.gz"
Remote "tar -czf $remoteTmp --exclude='.env' --exclude='.env.*' --exclude='auth.json' --exclude='*.lock' --exclude='*.pid' --exclude='state.db*' --exclude='kanban.db' --exclude='sessions' --exclude='logs' --exclude='cache' --exclude='audio_cache' --exclude='image_cache' -C /srv/hermes/workspace . 2>/dev/null"
scp -q -i "$Key" -P $Port ("${User}@${HostName}:$remoteTmp") "$tmp"
Remote "rm -f $remoteTmp"
$workspaceSnapshot = Join-Path $RepoRoot "snapshots\workspace"
tar -xzf "$tmp" -C "$workspaceSnapshot"
Remove-Item -Force "$tmp" -ErrorAction SilentlyContinue
PullFile "/home/hermes/.hermes/SOUL.md" (Join-Path $RepoRoot "snapshots\hermes\SOUL.md")
PullFile "/home/hermes/.hermes/memories/MEMORY.md" (Join-Path $RepoRoot "snapshots\hermes\memories\MEMORY.md")
PullFile "/home/hermes/.hermes/memories/USER.md" (Join-Path $RepoRoot "snapshots\hermes\memories\USER.md")
Remote "if test -f /home/hermes/.hermes/config.yaml; then sed -E 's/(token|api_key|apikey|secret|password|authorization):.*/\1: <redacted>/Ig' /home/hermes/.hermes/config.yaml; fi" | Set-Content -Encoding UTF8 (Join-Path $RepoRoot "snapshots\hermes\config.sanitized.yaml")
Remote "systemctl cat hermes-gateway.service 2>/dev/null || true" | Set-Content -Encoding UTF8 (Join-Path $RepoRoot "snapshots\systemd\hermes-gateway.service")
Remote "find /home/hermes/.hermes -maxdepth 3 -type d \( -iname skills -o -iname skill \) -print 2>/dev/null; find /home/hermes/.hermes/skills -maxdepth 2 -type f -name 'SKILL.md' -print 2>/dev/null" | Set-Content -Encoding UTF8 (Join-Path $RepoRoot "snapshots\hermes\skills.txt")
Remote 'echo synced_at=$(date -Iseconds); echo service_active=$(systemctl is-active hermes-gateway.service 2>/dev/null || true); echo service_enabled=$(systemctl is-enabled hermes-gateway.service 2>/dev/null || true); echo workspace_exists=$(test -d /srv/hermes/workspace && echo yes || echo no); echo hermes_home_exists=$(test -d /home/hermes/.hermes && echo yes || echo no)' | Set-Content -Encoding UTF8 (Join-Path $RepoRoot "snapshots\healthcheck.txt")
