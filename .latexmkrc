# latexmk configuration: `latexmk` builds main.pdf with pdfLaTeX + Biber.
# Use `latexmk -lualatex` to build with LuaLaTeX instead.
@default_files = ('main.tex');
$pdf_mode = 1;
$bibtex_use = 2;          # run biber when needed and delete .bbl on clean
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$lualatex = 'lualatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$clean_ext = 'bbl run.xml synctex.gz lol loa glo gls glg acn acr alg ist xdy tdo nav snm vrb fls';
