# Source boundary

This note assigns reusable visual policy to Diakosmos. Consumers define each research concept and outline. Consumers also adapt each visual layout to its venue.

| Admitted responsibility | Package location |
| --- | --- |
| hue values and house-style roles | `diakosmos-colors.sty` and the two generated color files |
| Unicode-engine font policy | `diakosmos-fonts.sty` |
| semantic text inside mathematics | `diakosmos-type.sty` |
| card grammar | `diakosmos-cards.sty` for posters; `diakosmos-panels.sty` for figure panels |
| generic TikZ primitives | `diakosmos-tikz.sty` |
| authoritative palette specifications | `resources/` |

Consumers retain:

- palettes that assign roles to research concepts;
- figure grammar defined by a project;
- preambles, logos and icons;
- retained external images.

Canonical TeX colors use the `diakosmos-` namespace. While adopting the namespaced interfaces, a consumer may provide temporary aliases for former macro and color names.

The `resources/` directory has no index because `l3build` installs the directory wholesale and every file in it is a package resource.

The repository preserves the history of twelve files moved from Geonexus. The preserved history also covers predecessor files at former paths. The bootstrap commit deletes the preambles because they depend on Geonexus. The same commit deletes the figure style owned by its project. Finally, the commit narrows the remaining files to the scope stated in the table.
