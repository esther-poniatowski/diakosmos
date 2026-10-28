# Compile fixtures

The fixtures show whether each module compiles through its supported engine.

- [Colors under pdfLaTeX](colors-pdftex.tex): verifies the engine-independent color module
- [TikZ under pdfLaTeX](tikz-pdftex.tex): verifies the namespaced drawing primitives
- [Default fonts under a Unicode engine](fonts-default-unicode.tex): verifies the default font policy
- [Raleway fonts under a Unicode engine](fonts-raleway-unicode.tex): verifies the alternate font policy
- [Type roles under a Unicode engine](type-unicode.tex): verifies every semantic type helper
- [Cards under a Unicode engine](cards-unicode.tex): verifies the card module and its transitive dependencies
- [Palette adapter check](check-palette-adapter.sh): proves that each stale generated layer fails independently
