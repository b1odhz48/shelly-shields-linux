#!/usr/bin/env bash
set -euo pipefail
if [[ "${1:-}" != '--apply' ]];then
 echo 'Preview: sudo pacman -S --needed ufw; sudo ufw default deny incoming; sudo ufw default allow outgoing; sudo systemctl enable --now ufw.service; sudo ufw enable'
 echo 'CAUTION: Firewall changes may disconnect SSH/remote access. Run with --apply only from a local console after reviewing.'
 exit 0
fi
if [[ -n "${SSH_CONNECTION:-}" ]];then echo 'Refusing to apply over SSH' >&2;exit 1;fi
read -r -p 'Apply local UFW baseline? Type APPLY: ' response
[[ "$response" == APPLY ]] || exit 1
sudo pacman -S --needed ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo systemctl enable --now ufw.service
sudo ufw enable
