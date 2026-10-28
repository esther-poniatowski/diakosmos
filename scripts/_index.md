# Maintainer scripts

The scripts enforce the package's generated and runtime contracts.

- [`build-palettes.sh`](build-palettes.sh): regenerates the committed palette layers or rejects stale layers
- [`check.sh`](check.sh): checks the palette before the package
- [`check-package.sh`](check-package.sh): verifies source boundaries, direct compilation and installed use
- [`check-source-boundary.sh`](check-source-boundary.sh): rejects workspace paths and project concepts from package sources
