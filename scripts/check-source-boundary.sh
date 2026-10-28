#!/bin/sh
set -eu

repository_root=${1:-"$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"}

if rg -n -P \
  '\\RootPath|artifacts/_common|projects/|mixture-input-encoding|compplane|outplaneannot|question(fill|ring|wash)|medallion|net(bound|fill)|spine(fill|edge)|stepmark|factoraccent|supplement|one-network|argument chain|contact line|^modes:|^css:|\\definecolor\{(?!diakosmos-hue-)|\\colorlet\{(?!diakosmos-)' \
  --glob 'diakosmos-*.sty' \
  --glob 'diakosmos-color-*.tex' \
  --glob '*.yml' \
  "$repository_root"
then
  printf '%s\n' 'Package sources contain a workspace path or project concept.' >&2
  exit 1
fi

printf '%s\n' 'Source boundary: pass'
