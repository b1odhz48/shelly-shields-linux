#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[[ "$EUID" == 0 ]] || { echo 'Run as root on an Arch build host' >&2;exit 1; }
command -v mkarchiso >/dev/null || { echo 'Install archiso first: pacman -S archiso' >&2;exit 1; }
BASE=/usr/share/archiso/configs/releng
[[ -d "$BASE" ]] || { echo 'Missing archiso releng profile' >&2;exit 1; }
WORK="$ROOT/.build-profile";OUT="$ROOT/out";CACHE="$ROOT/.work"
mkdir -p "$OUT"
rm -rf "$WORK";cp -a "$BASE" "$WORK"
cat "$ROOT/archiso/packages.x86_64" >> "$WORK/packages.x86_64"
cp -a "$ROOT/archiso/airootfs/." "$WORK/airootfs/"
install -Dm755 "$ROOT/bin/shelly" "$WORK/airootfs/usr/local/bin/shelly"
# releng profile metadata may change across Archiso releases; inspect before distribution
sed -i 's/^iso_name=.*/iso_name="shelly-shields"/' "$WORK/profiledef.sh"
mkarchiso -v -w "$CACHE" -o "$OUT" "$WORK"
echo "ISO artifacts: $OUT"
