# Diakosmos

Diakosmos supplies a modular TeX house style for scientific articles, posters and slides. Consumers load each module independently. The repository provides no umbrella package.

## Modules

Each module supplies one visual concern.

| Module | Reader goal |
| --- | --- |
| `diakosmos-colors` | load namespaced hue values and medium-independent house roles |
| `diakosmos-fonts` | select the Unicode-engine font policy, with an optional `raleway` variant |
| `diakosmos-type` | write semantic text labels inside mathematics |
| `diakosmos-cards` | build the house-style card grammar |
| `diakosmos-tikz` | draw namespaced shadows, flow arrows and tapered arrows |

Consumers define project palettes, point sizes and preambles. Consumers also own icons and logos.

## Installation

Install the package into an isolated TeX tree through `l3build`:

```sh
l3build install --texmfhome /path/to/texmf
```

Ktisma invokes the same command for an exact dependency commit. Each TeX source loads only its required modules:

```latex
\usepackage{diakosmos-colors}
\usepackage{diakosmos-tikz}
```

The font, type and card modules require LuaLaTeX or XeLaTeX. The color and TikZ modules also support pdfLaTeX.

## Verification

Run the source-boundary scan, direct compile fixtures and isolated installed-use fixtures. XeLaTeX is the default Unicode engine. Set `DIAKOSMOS_UNICODE_ENGINE=lualatex` to exercise LuaLaTeX.

```sh
scripts/check.sh
```

The [source boundary](docs/architecture/source-boundary.md) records the former Geonexus inputs admitted to the package. Separately, the palette tool will generate palettes and detect drift.

## Distribution state

Only authorized collaborators may access the private repository. Publishing through a public TeX archive requires explicit terms. Those terms must let others copy the package. The terms must also let others share the package.
