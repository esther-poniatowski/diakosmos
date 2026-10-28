#!/bin/sh
set -eu

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
test_root=$(mktemp -d "${TMPDIR:-/tmp}/diakosmos-palette-adapter.XXXXXX")
test_root=$(CDPATH= cd -- "$test_root" && pwd)
trap 'rm -rf "$test_root"' EXIT HUP INT TERM

mkdir -p "$test_root/scripts" "$test_root/resources"
cp "$repository_root/scripts/build-palettes.sh" "$test_root/scripts/"
cp "$repository_root/resources/diakosmos-hues.palette.yml" \
  "$repository_root/resources/diakosmos-house.palette.yml" \
  "$test_root/resources/"

adapter="$test_root/scripts/build-palettes.sh"

"$adapter" write
cmp "$repository_root/diakosmos-color-values.tex" "$test_root/diakosmos-color-values.tex"
cmp "$repository_root/diakosmos-color-roles.tex" "$test_root/diakosmos-color-roles.tex"
"$adapter" check

for output in diakosmos-color-values.tex diakosmos-color-roles.tex
do
  printf '%s\n' '% planted stale layer' >> "$test_root/$output"
  report="$test_root/$output.report"
  if "$adapter" check >"$report" 2>&1
  then
    printf '%s\n' "Palette adapter accepted a stale layer: $output" >&2
    exit 1
  fi
  grep -F "stale: $test_root/$output" "$report"
  "$adapter" write
  "$adapter" check
done

printf '%s\n' 'Palette adapter tests: pass'
