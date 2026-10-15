# latexmk configuration: `latexmk` builds main.pdf with pdfLaTeX + Biber.
# Overleaf also reads this file (it must be called `latexmkrc`, without a dot).
# Use `latexmk -lualatex` to build with LuaLaTeX instead.
@default_files = ('main.tex');
$pdf_mode = 1;
$bibtex_use = 2;          # run biber when needed and delete .bbl on clean
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$lualatex = 'lualatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';
$clean_ext = 'bbl run.xml synctex.gz lol loa glo gls glg acn acr alg ist xdy tdo nav snm vrb fls';

# biblatex rewrites <name>.run.xml on every pass. Its content is irrelevant to
# decide whether LaTeX must run again (biblatex says so in the log), and checking
# it costs one extra, useless pdfLaTeX pass. Important on Overleaf's free plan,
# whose compile time limit is short.
$hash_calc_ignore_pattern{'xml'} = '.*';
