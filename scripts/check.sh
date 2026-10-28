#!/bin/sh
set -eu

repository_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
build_root="$repository_root/.build"
direct_root="$build_root/direct"
installed_root="$build_root/installed"
texmf_root="$build_root/texmf"
texmf_cache="$build_root/texmf-cache"
texmf_var="$build_root/texmf-var"
unicode_engine=${DIAKOSMOS_UNICODE_ENGINE:-xelatex}

case "$unicode_engine" in
  lualatex|xelatex) ;;
  *)
    printf '%s\n' "Unsupported Unicode engine: $unicode_engine" >&2
    exit 2
    ;;
esac

rm -rf "$direct_root" "$installed_root" "$texmf_root"
mkdir -p "$direct_root" "$installed_root" "$texmf_root" "$texmf_cache" "$texmf_var"
export TEXMFCACHE="$texmf_cache"
export TEXMFVAR="$texmf_var"

if test "$unicode_engine" = lualatex && \
   test ! -f "$texmf_cache/luatex-cache/generic/names/luaotfload-names.luc.gz"
then
  luaotfload-tool --update --force
fi

"$repository_root/scripts/check-source-boundary.sh" "$repository_root"

compile_direct() {
  engine=$1
  fixture=$2
  output="$direct_root/${fixture%.tex}"
  mkdir -p "$output"
  TEXINPUTS="$repository_root:" latexmk \
    -silent "$engine" -interaction=nonstopmode -halt-on-error -file-line-error \
    -outdir="$output" "$repository_root/tests/$fixture"
  test -f "$output/${fixture%.tex}.pdf"
}

compile_direct -pdf colors-pdftex.tex
compile_direct -pdf tikz-pdftex.tex
compile_direct "-$unicode_engine" fonts-default-unicode.tex
compile_direct "-$unicode_engine" fonts-raleway-unicode.tex
compile_direct "-$unicode_engine" type-unicode.tex
compile_direct "-$unicode_engine" cards-unicode.tex

l3build install --texmfhome "$texmf_root"

for resource in diakosmos-house.palette.yml diakosmos-hues.palette.yml
do
  expected_resource="$texmf_root/tex/latex/diakosmos/resources/$resource"
  resolved_resource=$(TEXMFHOME="$texmf_root" kpsewhich "$resource")
  test "$resolved_resource" = "$expected_resource"
done

compile_installed() {
  engine=$1
  fixture=$2
  output_directory="$installed_root/${fixture%.tex}"
  mkdir -p "$output_directory"
  (
    cd "$output_directory"
    TEXMFHOME="$texmf_root" latexmk \
      -silent "$engine" -interaction=nonstopmode -halt-on-error -file-line-error \
      "$repository_root/tests/$fixture"
  )
  test -f "$output_directory/${fixture%.tex}.pdf"
  input_record="$output_directory/${fixture%.tex}.fls"
  if ! rg -q "^INPUT $texmf_root/tex/latex/diakosmos/diakosmos-" "$input_record"
  then
    printf '%s\n' "Installed fixture did not load Diakosmos from $texmf_root: $fixture" >&2
    exit 1
  fi
  if rg '^INPUT .*/diakosmos-[^/]*\.(sty|tex)$' "$input_record" | \
     rg -v "^INPUT $texmf_root/tex/latex/diakosmos/"
  then
    printf '%s\n' "Installed fixture loaded a Diakosmos source outside $texmf_root: $fixture" >&2
    exit 1
  fi
}

compile_installed -pdf colors-pdftex.tex
compile_installed -pdf tikz-pdftex.tex
compile_installed "-$unicode_engine" fonts-default-unicode.tex
compile_installed "-$unicode_engine" fonts-raleway-unicode.tex
compile_installed "-$unicode_engine" type-unicode.tex
compile_installed "-$unicode_engine" cards-unicode.tex

if grep -ERn --include='*.log' \
  'LaTeX Warning:|Package .* Warning:|Overfull|Underfull|First Aid' \
  "$direct_root" "$installed_root"
then
  printf '%s\n' 'TeX warnings: fail' >&2
  exit 1
fi

printf '%s\n' "Diakosmos checks ($unicode_engine): pass"
