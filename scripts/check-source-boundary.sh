#!/bin/sh
set -eu

repository_root=${1:-"$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"}

if ! command -v rg >/dev/null 2>&1
then
  printf '%s\n' 'Source boundary requires ripgrep (rg).' >&2
  exit 2
fi

if rg -n -P \
  '\\RootPath|artifacts/_common|projects/|mixture-input-encoding|compplane|outplaneannot|question(fill|ring|wash)|medallion|net(bound|fill)|spine(fill|edge)|stepmark|factoraccent|supplement|one-network|argument chain|contact line|^modes:|^css:|\\definecolor\{(?!diakosmos-hue-)|\\colorlet\{(?!diakosmos-)' \
  --glob 'diakosmos-*.sty' \
  --glob 'diakosmos-color-*.tex' \
  --glob '*.yml' \
  "$repository_root"
then
  printf '%s\n' 'Package sources contain a workspace path or project concept.' >&2
  exit 1
else
  scan_status=$?
  if test "$scan_status" -ne 1
  then
    printf '%s\n' "Source boundary scan failed with status $scan_status." >&2
    exit "$scan_status"
  fi
fi

printf '%s\n' 'Source boundary: pass'
