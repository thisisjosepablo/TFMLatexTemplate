# Convenience targets (require latexmk, included in TeX Live and MiKTeX)
.PHONY: all pdf lua watch final review figures clean distclean

all: pdf

pdf:            ## Build main.pdf with pdfLaTeX + Biber
	latexmk main.tex

lua:            ## Build main.pdf with LuaLaTeX + Biber
	latexmk -lualatex main.tex

watch:          ## Rebuild automatically whenever a file changes
	latexmk -pvc main.tex

final:          ## Build main.pdf without guidance boxes and to-do notes
	latexmk -pdflatex='pdflatex -interaction=nonstopmode %O "\PassOptionsToClass{final}{tfmthesis}\input{%S}"' main.tex

review:         ## Build main.pdf with line numbers and a DRAFT watermark
	latexmk -pdflatex='pdflatex -interaction=nonstopmode %O "\PassOptionsToClass{review}{tfmthesis}\input{%S}"' main.tex

figures:        ## Regenerate the example figures (needs numpy and matplotlib)
	python3 figures/src/example_figures.py

clean:          ## Remove auxiliary files
	latexmk -c

distclean:      ## Remove auxiliary files and the PDF
	latexmk -C
