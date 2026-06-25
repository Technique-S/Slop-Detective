#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

detect_platform() {
  if command -v opencode &>/dev/null; then
    echo "opencode"
  elif [ -d "$HOME/.config/opencode" ]; then
    echo "opencode-global"
  elif [ -d "$HOME/.claude/skills" ]; then
    echo "claude-code"
  elif command -v claude &>/dev/null && [ -d "$HOME/.claude" ]; then
    echo "claude-code"
  elif command -v gemini &>/dev/null || [ -d "$HOME/.gemini/skills" ]; then
    echo "gemini-cli"
  elif command -v gh &>/dev/null && gh extension list 2>/dev/null | grep -q copilot; then
    echo "copilot-cli"
  elif [ -d ".cursor/rules" ]; then
    echo "cursor"
  elif [ -f ".windsurfrules" ]; then
    echo "windsurf"
  else
    echo "unknown"
  fi
}

install_to_opencode() {
  local target="$1"
  if [ -z "$target" ]; then
    target="$HOME/.config/opencode/skills"
  fi
  mkdir -p "$target"
  echo "Installing to $target ..."
  cp -r "$REPO_DIR"/skills/* "$target/"
  if [ -d "$target/repository-orchestrator" ]; then
    echo "  orchestrator already exists in skills, skipping"
  else
    mkdir -p "$target/repository-orchestrator"
    cp -r "$REPO_DIR/orchestrator"/* "$target/repository-orchestrator/"
  fi
  echo "Done. Skills installed to $target"
  echo ""
  echo "Add to opencode.json to auto-load:"
  echo '  "skills": { "paths": ["'"$target"'"] }'
}

install_to_claude() {
  local target="$HOME/.claude/skills"
  mkdir -p "$target"
  echo "Installing to $target ..."
  cp -r "$REPO_DIR"/skills/* "$target/"
  mkdir -p "$target/repository-orchestrator"
  cp -r "$REPO_DIR/orchestrator"/* "$target/repository-orchestrator/"
  echo "Done. Skills installed to $target"
  echo "Claude Code auto-loads skills from ~/.claude/skills/ — restart Claude Code to pick them up."
}

install_to_gemini() {
  local target="$HOME/.gemini/skills"
  mkdir -p "$target"
  echo "Installing to $target ..."
  cp -r "$REPO_DIR"/skills/* "$target/"
  mkdir -p "$target/repository-orchestrator"
  cp -r "$REPO_DIR/orchestrator"/* "$target/repository-orchestrator/"
  echo "Done. Skills installed to $target"
  echo "Use 'activate_skill' in Gemini CLI to load them."
}

install_to_cursor() {
  local target="$HOME/.cursor/rules"
  mkdir -p "$target"
  echo "Installing as Cursor rules to $target ..."
  cp -r "$REPO_DIR"/skills/* "$target/"
  cp -r "$REPO_DIR/orchestrator"/* "$target/"
  echo "Done. Restart Cursor to pick up the rules."
}

install_to_windsurf() {
  local target="$HOME/.windsurfrules"
  echo "Appending to $target ..."
  echo "" >> "$target"
  echo "# Repository Excellence Suite" >> "$target"
  echo "# See https://github.com/Technique-S/Slop-Detective" >> "$target"
  cat "$REPO_DIR/orchestrator/README.md" >> "$target"
  echo "Done. Windsurf rules updated."
}

print_manual_instructions() {
  echo "Could not auto-detect your AI platform."
  echo ""
  echo "Manual install options:"
  echo ""
  echo "  Claude Code:     cp -r skills/* ~/.claude/skills/"
  echo "                   cp -r orchestrator/ ~/.claude/skills/repository-orchestrator/"
  echo ""
  echo "  OpenCode:        cp -r skills/* ~/.config/opencode/skills/"
  echo "                   cp -r orchestrator/ ~/.config/opencode/skills/repository-orchestrator/"
  echo "                   Then add to opencode.json:"
  echo '                   "skills": { "paths": ["~/.config/opencode/skills"] }'
  echo ""
  echo "  Gemini CLI:      cp -r skills/* ~/.gemini/skills/"
  echo "                   cp -r orchestrator/ ~/.gemini/skills/repository-orchestrator/"
  echo "                   Use activate_skill to load."
  echo ""
  echo "  Cursor:          cp -r skills/* ~/.cursor/rules/"
  echo "                   cp -r orchestrator/* ~/.cursor/rules/"
  echo ""
  echo "Or just point your AI agent at this repo and tell it to use the skills."
  echo "Each skill in skills/<name>/SKILL.md has proper frontmatter and description."
}

main() {
  local platform
  platform=$(detect_platform)
  echo "Detected platform: $platform"
  echo ""

  case "$platform" in
    opencode|opencode-global)
      local target=""
      if [ "$platform" = "opencode-global" ]; then
        target="$HOME/.config/opencode/skills"
      fi
      install_to_opencode "$target"
      ;;
    claude-code)
      install_to_claude
      ;;
    gemini-cli)
      install_to_gemini
      ;;
    cursor)
      install_to_cursor
      ;;
    windsurf)
      install_to_windsurf
      ;;
    copilot-cli)
      echo "GitHub Copilot CLI uses a plugin system. See:"
      echo "  https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-cli"
      print_manual_instructions
      ;;
    *)
      print_manual_instructions
      ;;
  esac
}

main "$@"
