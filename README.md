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
| `diakosmos-panels` | build lettered figure panels whose colours and fonts the consumer binds |
| `diakosmos-tikz` | draw namespaced shadows, flow arrows, tapered arrows, page canvases and three-dimensional axes |

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

The font, type and card modules require LuaLaTeX or XeLaTeX. The color, TikZ and panel modules also support pdfLaTeX.

## Verification

Install the exact palette tool selected by the derived lock:

```sh
conda-lock install --name diakosmos-tools conda-lock.yml
```

The palette check compares both committed TeX layers with the authoritative records:

```sh
conda run -n diakosmos-tools scripts/build-palettes.sh check
```

The package check runs the source-boundary scan, direct compile fixtures and isolated installed-use fixtures. XeLaTeX is the default Unicode engine. Set `DIAKOSMOS_UNICODE_ENGINE=lualatex` to exercise LuaLaTeX.

```sh
scripts/check-package.sh
```

The combined check requires the locked Chromata prefix and an independent TeX distribution. A second Conda prefix can mix runtime libraries with the first.

```sh
scripts/check.sh
```

After editing a palette record, regenerate and recheck the committed layers:

```sh
conda run -n diakosmos-tools scripts/build-palettes.sh write
conda run -n diakosmos-tools scripts/build-palettes.sh check
```

The adapter owns every output path, namespace and public role-name mapping. The [source boundary](docs/architecture/source-boundary.md) records the former Geonexus inputs admitted to the package.

## License

The [license terms](LICENSE) apply under the General Public License, release 3 or any subsequent release.
