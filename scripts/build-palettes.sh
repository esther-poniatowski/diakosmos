#!/bin/sh
set -eu

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
resource_root="$repository_root/resources"

case "${1:-check}" in
  check)
    set -- --check
    ;;
  write)
    set --
    ;;
  *)
    printf '%s\n' 'Usage: scripts/build-palettes.sh [check|write]' >&2
    exit 2
    ;;
esac

if ! command -v chromata-build >/dev/null 2>&1
then
  printf '%s\n' 'Palette generation requires Chromata from the locked tool environment.' >&2
  exit 2
fi

chromata-build \
  --root "$resource_root" \
  --spec "$resource_root/diakosmos-hues.palette.yml" \
  --values-out "$repository_root/diakosmos-color-values.tex" \
  --source-label resources/diakosmos-hues.palette.yml \
  --values-prefix diakosmos-hue- \
  "$@"

chromata-build \
  --root "$resource_root" \
  --spec "$resource_root/diakosmos-house.palette.yml" \
  --roles-out "$repository_root/diakosmos-color-roles.tex" \
  --source-label resources/diakosmos-house.palette.yml \
  --values-prefix diakosmos-hue- \
  --roles-prefix diakosmos- \
  --tex-name borderfunc=border-functional \
  --tex-name bordersubtle=border-subtle \
  --tex-name texttertiary=text-tertiary \
  --tex-name textsecondary=text-secondary \
  --tex-name textprimary=text-primary \
  --tex-name textinverse=text-inverse \
  --tex-name chromecore=chrome-core \
  --tex-name chromedeep=chrome-deep \
  --tex-name chromealt=chrome-alternate \
  --tex-name cardground=card-ground \
  --tex-name cardring=card-ring \
  --tex-name cardcast=card-cast \
  --tex-name cardshadow=card-shadow \
  --tex-name cardshadowdk=card-shadow-deep \
  "$@"
