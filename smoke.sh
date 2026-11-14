#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
python -m py_compile "$ROOT/bin/shelly"
"$ROOT/bin/shelly" tools
"$ROOT/install.sh" --dry-run --profile core
"$ROOT/hardening/apply.sh"
echo 'Smoke tests passed (no packages installed)'
