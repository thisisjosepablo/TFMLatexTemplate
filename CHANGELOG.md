# Changelog

All notable changes to this template are documented in this file. The format is
based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project
follows [Semantic Versioning](https://semver.org/).

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
