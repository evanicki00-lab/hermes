$Utf8NoBom = New-Object System.Text.UTF8Encoding $false
$OutputEncoding = $Utf8NoBom
[Console]::OutputEncoding = $Utf8NoBom
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$patterns = @(
  'TELEGRAM_BOT_TOKEN',
  '[0-9]{8,12}:[A-Za-z0-9_-]{30,}',
  'OPENAI_API_KEY',
  'sk-[A-Za-z0-9_-]{20,}',
  'BEGIN (OPENSSH|RSA|EC|DSA) PRIVATE KEY',
  '(^|[\\/])\.env(\.|$|[\\/])',
  '(?i)(password|passwd|secret|api[_-]?key|token)\s*[:=]\s*[^\s<][^\r\n]+'
)
$exclude = '\.git|scripts[\\/]verify-no-secrets|README\.md|AGENTS\.md|docs[\\/]operations[\\/]update-telegram-token\.md|docs[\\/]integrations'
$hits = @()
Get-ChildItem -LiteralPath $RepoRoot -Recurse -File -Force | Where-Object { $_.FullName -notmatch $exclude } | ForEach-Object {
  $file = $_.FullName
  if ($_.Name -eq "auth.json") { $hits += "$file :: forbidden auth.json file" }
  $text = Get-Content -LiteralPath $file -Raw -ErrorAction SilentlyContinue
  foreach ($p in $patterns) {
    if ($text -match $p) { $hits += "$file :: $p" }
  }
}
if ($hits.Count -gt 0) {
  Write-Error ("Potential secrets found:`n" + ($hits -join "`n"))
  exit 1
}
Write-Output "No obvious secrets found."
