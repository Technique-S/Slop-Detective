param(
  [string]$Target = "",
  [switch]$Help
)

if ($Help) {
  Write-Host "Repository Excellence Suite Installer"
  Write-Host ""
  Write-Host "Usage: .\install.ps1 [-Target <path>]"
  Write-Host ""
  Write-Host "Without -Target, auto-detects the platform and installs to the default location."
  Write-Host "With -Target, installs all skills to the specified directory."
  exit 0
}

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Detect-Platform {
  if (Get-Command opencode -ErrorAction SilentlyContinue) {
    return "opencode"
  }
  if (Test-Path "$env:USERPROFILE\.config\opencode") {
    return "opencode-global"
  }
  if (Test-Path "$env:USERPROFILE\.claude\skills") {
    return "claude-code"
  }
  if (Get-Command claude -ErrorAction SilentlyContinue) {
    if (Test-Path "$env:USERPROFILE\.claude") {
      return "claude-code"
    }
  }
  if ((Get-Command gemini -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.gemini\skills")) {
    return "gemini-cli"
  }
  if (Get-Command gh -ErrorAction SilentlyContinue) {
    $exts = gh extension list 2>$null
    if ($exts -match "copilot") {
      return "copilot-cli"
    }
  }
  if (Test-Path ".cursor\rules") {
    return "cursor"
  }
  if (Test-Path ".windsurfrules") {
    return "windsurf"
  }
  return "unknown"
}

function Install-ToOpenCode {
  param([string]$TargetDir)
  if (-not $TargetDir) {
    $TargetDir = "$env:USERPROFILE\.config\opencode\skills"
  }
  if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
  }
  Write-Host "Installing to $TargetDir ..."
  Copy-Item -Path "$RepoDir\skills\*" -Destination $TargetDir -Recurse -Force
  $orchTarget = "$TargetDir\repository-orchestrator"
  if (-not (Test-Path $orchTarget)) {
    New-Item -ItemType Directory -Path $orchTarget -Force | Out-Null
  }
  Copy-Item -Path "$RepoDir\orchestrator\*" -Destination $orchTarget -Recurse -Force
  Write-Host "Done. Skills installed to $TargetDir"
  Write-Host ""
  Write-Host "Add to opencode.json to auto-load:"
  Write-Host '  "skills": { "paths": ["' + $TargetDir + '"] }'
}

function Install-ToClaude {
  $target = "$env:USERPROFILE\.claude\skills"
  if (-not (Test-Path $target)) {
    New-Item -ItemType Directory -Path $target -Force | Out-Null
  }
  Write-Host "Installing to $target ..."
  Copy-Item -Path "$RepoDir\skills\*" -Destination $target -Recurse -Force
  $orchTarget = "$target\repository-orchestrator"
  if (-not (Test-Path $orchTarget)) {
    New-Item -ItemType Directory -Path $orchTarget -Force | Out-Null
  }
  Copy-Item -Path "$RepoDir\orchestrator\*" -Destination $orchTarget -Recurse -Force
  Write-Host "Done. Skills installed to $target"
  Write-Host "Claude Code auto-loads from ~/.claude/skills/ — restart Claude Code to activate."
}

function Install-ToGemini {
  $target = "$env:USERPROFILE\.gemini\skills"
  if (-not (Test-Path $target)) {
    New-Item -ItemType Directory -Path $target -Force | Out-Null
  }
  Write-Host "Installing to $target ..."
  Copy-Item -Path "$RepoDir\skills\*" -Destination $target -Recurse -Force
  $orchTarget = "$target\repository-orchestrator"
  if (-not (Test-Path $orchTarget)) {
    New-Item -ItemType Directory -Path $orchTarget -Force | Out-Null
  }
  Copy-Item -Path "$RepoDir\orchestrator\*" -Destination $orchTarget -Recurse -Force
  Write-Host "Done. Skills installed to $target"
  Write-Host "Use activate_skill in Gemini CLI to load."
}

function Install-ToCursor {
  $target = "$env:USERPROFILE\.cursor\rules"
  if (-not (Test-Path $target)) {
    New-Item -ItemType Directory -Path $target -Force | Out-Null
  }
  Write-Host "Installing as Cursor rules to $target ..."
  Copy-Item -Path "$RepoDir\skills\*" -Destination $target -Recurse -Force
  Copy-Item -Path "$RepoDir\orchestrator\*" -Destination $target -Recurse -Force
  Write-Host "Done. Restart Cursor to pick up the rules."
}

function Show-ManualInstructions {
  Write-Host "Could not auto-detect your AI platform."
  Write-Host ""
  Write-Host "Manual install options:"
  Write-Host ""
  Write-Host "  Claude Code:"
  Write-Host "    Copy-Item -Path 'skills\*' -Destination ~\.claude\skills\ -Recurse"
  Write-Host "    Copy-Item -Path 'orchestrator\*' -Destination ~\.claude\skills\repository-orchestrator\ -Recurse"
  Write-Host ""
  Write-Host "  OpenCode:"
  Write-Host "    Copy-Item -Path 'skills\*' -Destination ~\.config\opencode\skills\ -Recurse"
  Write-Host "    Copy-Item -Path 'orchestrator\*' -Destination ~\.config\opencode\skills\repository-orchestrator\ -Recurse"
  Write-Host '    Then add to opencode.json: "skills": { "paths": ["~/.config/opencode/skills"] }'
  Write-Host ""
  Write-Host "  Gemini CLI:"
  Write-Host "    Copy-Item -Path 'skills\*' -Destination ~\.gemini\skills\ -Recurse"
  Write-Host "    Copy-Item -Path 'orchestrator\*' -Destination ~\.gemini\skills\repository-orchestrator\ -Recurse"
  Write-Host ""
  Write-Host "  Cursor:"
  Write-Host "    Copy-Item -Path 'skills\*' -Destination ~\.cursor\rules\ -Recurse"
  Write-Host ""
  Write-Host "Or just point your AI agent at this repo URL and tell it to use the skills."
  Write-Host "Each skill has proper frontmatter for auto-discovery."
}

function Main {
  if ($Target) {
    Write-Host "Installing to custom target: $Target ..."
    if (-not (Test-Path $Target)) {
      New-Item -ItemType Directory -Path $Target -Force | Out-Null
    }
    Copy-Item -Path "$RepoDir\skills\*" -Destination $Target -Recurse -Force
    $orchTarget = "$Target\repository-orchestrator"
    if (-not (Test-Path $orchTarget)) {
      New-Item -ItemType Directory -Path $orchTarget -Force | Out-Null
    }
    Copy-Item -Path "$RepoDir\orchestrator\*" -Destination $orchTarget -Recurse -Force
    Write-Host "Done."
    return
  }

  $platform = Detect-Platform
  Write-Host "Detected platform: $platform"
  Write-Host ""

  switch ($platform) {
    "opencode" { Install-ToOpenCode }
    "opencode-global" { Install-ToOpenCode -TargetDir "$env:USERPROFILE\.config\opencode\skills" }
    "claude-code" { Install-ToClaude }
    "gemini-cli" { Install-ToGemini }
    "cursor" { Install-ToCursor }
    "copilot-cli" {
      Write-Host "GitHub Copilot CLI uses a different plugin system."
      Write-Host "See: https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-cli"
      Show-ManualInstructions
    }
    default { Show-ManualInstructions }
  }
}

Main
