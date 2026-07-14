# Install Grok Cyber Skills mode-D wrapper + clone 817-skill library
param(
    [switch]$Project,
    [switch]$Update,
    [string]$KitRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

if ($Project) {
    $base = Join-Path (Get-Location) ".grok"
    Write-Host "Install mode: PROJECT -> $base"
} else {
    $base = Join-Path $env:USERPROFILE ".grok"
    Write-Host "Install mode: GLOBAL -> $base"
}

$skills = Join-Path $base "skills"
$commands = Join-Path $base "commands"
$tools = Join-Path $base "tools"
$toolkit = Join-Path $tools "cyber-skills"
$dst = Join-Path $skills "cyber"

New-Item -ItemType Directory -Force -Path $skills, $commands, $tools, $dst | Out-Null

Copy-Item -Recurse -Force (Join-Path $KitRoot "skills\cyber\*") $dst
Write-Host "  skill: cyber (+ search script)"

Get-ChildItem (Join-Path $KitRoot "commands") -Filter "*.md" | ForEach-Object {
    Copy-Item -Force $_.FullName (Join-Path $commands $_.Name)
    Write-Host "  command: $($_.Name)"
}

$repo = "https://github.com/mukul975/Anthropic-Cybersecurity-Skills.git"
if (-not (Test-Path (Join-Path $toolkit "index.json"))) {
    Write-Host "  cloning 817-skill library (large, may take a bit)..."
    git clone --depth 1 $repo $toolkit
} else {
    Write-Host "  toolkit present: $toolkit"
    if ($Update) {
        Write-Host "  git pull..."
        git -C $toolkit pull --ff-only
    }
}

if (Test-Path (Join-Path $toolkit "index.json")) {
    $idx = Get-Content (Join-Path $toolkit "index.json") -Raw | ConvertFrom-Json
    Write-Host ("  index: {0} skills (v{1})" -f $idx.total_skills, $idx.version)
} else {
    Write-Warning "index.json missing after clone"
}

Write-Host ""
Write-Host "Done. Mode D: router only - skills NOT copied into always-on list."
Write-Host ("  Toolkit: {0}" -f $toolkit)
Write-Host "  Try: /cyber-status  |  /cyber-find memory forensics  |  /cyber-run skill-name"
Write-Host "  Legal: authorized / own systems only for offensive playbooks."
