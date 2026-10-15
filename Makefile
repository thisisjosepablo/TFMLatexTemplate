# Convenience targets (require latexmk, included in TeX Live and MiKTeX)
.PHONY: all pdf guide watch final figures clean distclean

all: pdf

pdf:            ## Build main.pdf with pdfLaTeX + BibTeX
	latexmk -pdf main.tex

guide:          ## Build template-guide.pdf (the user guide of the template)
	latexmk -pdf template-guide.tex

watch:          ## Rebuild automatically whenever a file changes
	latexmk -pdf -pvc main.tex

final:          ## Build main.pdf without guidance boxes and to-do notes
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O "\PassOptionsToClass{final}{tfmthesis}\input{%S}"' main.tex

figures:        ## Regenerate the example figures (needs numpy and matplotlib)
	python3 figures/src/example_figures.py

clean:          ## Remove auxiliary files
	latexmk -c main.tex template-guide.tex

distclean:      ## Remove auxiliary files and the PDFs
	latexmk -C main.tex template-guide.tex
