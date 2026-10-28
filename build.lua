-- l3build configuration for Diakosmos.

module = "diakosmos"

packageversion = "0.1.0"
packagedate = "2026-10-28"

sourcefiles = {
  "diakosmos-*.sty",
  "diakosmos-color-*.tex",
  "resources/*.yml",
}

installfiles = {
  "diakosmos-*.sty",
  "diakosmos-color-*.tex",
}

typesetfiles = {}
checkfiles = {}
docfiles = {
  "README.md",
  "docs/*.md",
  "docs/architecture/*.md",
  "tests/*.tex",
}
textfiles = {}

flatten = false
flattentds = false

tdsdirs = {
  ["resources"] = "tex/latex/diakosmos/resources",
}

ctanpkg = "diakosmos"
ctanreadme = "README.md"
ctanzip = "diakosmos"
