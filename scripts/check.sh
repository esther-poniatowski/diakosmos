#!/bin/sh
set -eu

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

"$repository_root/scripts/build-palettes.sh" check
"$repository_root/tests/check-palette-adapter.sh"
"$repository_root/scripts/check-package.sh"
