#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE=core; DRY=0
while (($#)); do
 case "$1" in
  --profile) PROFILE="${2:?missing profile}";shift 2;;
  --dry-run) DRY=1;shift;;
  *) echo "Usage: $0 [--dry-run] [--profile core|recon|web|forensics|defense|nvidia]" >&2;exit 2;;
 esac
done
[[ -f "$ROOT/profiles/$PROFILE.txt" ]] || { echo 'Unknown profile' >&2;exit 2; }
mapfile -t PKGS < <(grep -vE '^[[:space:]]*(#|$)' "$ROOT/profiles/$PROFILE.txt")
echo "Profile: $PROFILE";printf 'Packages: %s
' "${PKGS[*]}"
if ((DRY));then echo 'DRY RUN: no changes';exit 0;fi
[[ "$(uname -s)" == Linux ]] && command -v pacman >/dev/null || { echo 'Arch Linux/pacman required' >&2;exit 1; }
if [[ "$EUID" == 0 ]];then echo 'Run as a normal user (sudo will be requested for packages)' >&2;exit 1;fi
AVAILABLE=(); MISSING=()
for pkg in "${PKGS[@]}";do
 if pacman -Si "$pkg" >/dev/null 2>&1;then AVAILABLE+=("$pkg");else MISSING+=("$pkg");fi
done
if ((${#MISSING[@]}));then printf 'Unavailable in enabled repos: %s
' "${MISSING[*]}";fi
if ((${#AVAILABLE[@]}));then sudo pacman -S --needed "${AVAILABLE[@]}";fi
mkdir -p "$HOME/.local/bin"
install -m 755 "$ROOT/bin/shelly" "$HOME/.local/bin/shelly"
echo 'Installed shelly CLI to ~/.local/bin. No desktop or boot configuration changed.'
