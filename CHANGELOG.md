# Changelog

All notable changes to this template are documented in this file. The format is
based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project
follows [Semantic Versioning](https://semver.org/).

## [1.2.0] – 2026-10-15

A first compilation from scratch is now about six times faster than in 1.0.0, so that
the template fits within the compile time limit of Overleaf's free plan.

### Changed
- The bibliography is processed by **natbib + BibTeX** by default, which is much faster
  than biblatex + Biber. biblatex is still available with the new `biblatex` class
  option. `bibstyle` accepts `numeric-comp`, `numeric`, `ieee`, `authoryear`, `apa` or
  the name of any BibTeX style. `references.bib` now uses BibTeX-compatible entries.
- TikZ/pgfgantt, algorithm2e and pdfpages are only loaded with the new `tikz`,
  `algorithms` and `pdfpages` class options (pdfpages is loaded automatically when an
  official cover is set). The Gantt chart example has moved to the user guide.
- The `glossaries`, `todonotes` and `tcolorbox` packages have been replaced by small
  built-in implementations with the same commands (`\newacronym`, `\gls`, `\glspl`,
  `\acrshort`…, `\todo`, the `guidance` environment). This also avoids loading
  `datatool`, which is very slow in TeX Live 2026.
- The cover's colour band is drawn without TikZ.

## [2.0.0] – 2026-10-15

### Changed
- **The class now uses exactly the same packages as the original template** by Francisco
  Charte: `babel`, `inputenc`, `fontenc`, `geometry`, `setspace`, `fancyhdr`, `helvet`,
  `wallpaper`, `textpos`, `etoolbox`, `natbib`, `csquotes`, `hyperref`, `booktabs`,
  `algorithm2e`, `listings` and `xcolor`. Everything else is plain LaTeX. A full compilation
  takes about half the time of v1.1.0.
- Bibliography with natbib + BibTeX (`bibstyle=numeric|authoryear`) instead of biblatex + Biber.
- Cross-references with `\autoref` instead of `cleveref`.
- Default typeface: Helvetica (`font=sans`, same metrics as Arial), as in the original
  template; `font=serif` gives Computer Modern.
- The official PDF cover is placed with `wallpaper`, as in the original template.
- The list of acronyms is a simple table in `frontmatter/acronyms.tex`.
- Gantt chart, subfigures, tables and the SDG table are built with plain LaTeX.

### Removed
- Options `review`, `modern` font, `biblatex`, `tikz`, `algorithms`, `pdfpages` and
  LuaLaTeX support, together with the packages they needed (TikZ, pgfgantt, tcolorbox,
  todonotes, lineno, siunitx, glossaries, cleveref, titlesec, caption, subcaption,
  tabularx, enumitem, microtype, newtx…). `algorithm2e` is always available.
- The `latexmkrc` file, no longer needed.

## [1.1.0] – 2026-10-15

### Changed
- The user guide is now a separate document, `template-guide.tex` (`template-guide.pdf`),
  so `main.tex` contains only your thesis and compiles much faster.
- `.latexmkrc` renamed to `latexmkrc` so that Overleaf uses it, and configured to avoid a
  useless extra pdfLaTeX pass caused by biblatex's `.run.xml` file.
- Microtypography is enabled only with the `final` option, and guidance boxes are no longer
  breakable. A full compilation of the thesis now takes about a third of the time, to fit
  within the 10-second limit of Overleaf's free plan.
- `lipsum` is no longer loaded.

### Added
- Tips for keeping compilation time low on Overleaf.

## [1.0.0] – 2026-10-15

First release, derived from the TFG template of Francisco Charte Ojeda for the
Escuela Politécnica Superior de Jaén
([fcharte/TFGLatexTemplate](https://github.com/fcharte/TFGLatexTemplate), CC0).

### Added
- `tfmthesis` document class, independent of any particular university, with all
  the personal and institutional data in a single `config.tex` file.
- Fully English content: user guide, chapter skeletons with guidance boxes, writing
  advice for Spanish speakers writing in English.
- Structure of a research Master's thesis (Introduction, Background, Objectives,
  Materials and Methods, Results, Discussion, Conclusions) and guidance for
  professional/engineering projects.
- Class options: `print`/digital layout, `final`, `review` (line numbers and
  watermark), `font=serif|sans|modern`, `secondlanguage=spanish|catalan|valencian|galician|basque|none`,
  `bibstyle=<any biblatex style>`, `english=british|american`, `uppercase`.
- Generated cover with logo placeholders, support for an official PDF cover, any
  number of supervisors with roles, licence page (Creative Commons or all rights
  reserved), supervisor's approval, declaration of originality, abstract and
  keywords in a second language, statement on the use of generative AI, list of
  acronyms and appendix on the Sustainable Development Goals.
- BibLaTeX + Biber bibliography, `cleveref` cross-references, `siunitx` tables,
  subfigures, TikZ and `pgfgantt` examples, algorithms, code listings with
  Inconsolata, reproducible example figures (`figures/src/`).
- Optional PDF/A-2b output with `\DocumentMetadata`.
- pdfLaTeX and LuaLaTeX support, `latexmk` configuration, `Makefile`, GitHub
  Actions workflow that tests option combinations and publishes the PDF and an
  Overleaf-ready ZIP with every release, and a preset for the EPSJ (Universidad de Jaén).
