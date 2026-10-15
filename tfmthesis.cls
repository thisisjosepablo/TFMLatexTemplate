%% ===========================================================================
%%  tfmthesis.cls -- LaTeX class for Master's Theses (Trabajo Fin de Máster)
%%                   at Spanish public universities, written in English
%% ---------------------------------------------------------------------------
%%  https://github.com/thisisjosepablo/TFMLatexTemplate
%%
%%  Based on the TFG template for the Department of Computer Science of the
%%  Escuela Politécnica Superior de Jaén (Universidad de Jaén), created by
%%  Francisco Charte Ojeda: https://github.com/fcharte/TFGLatexTemplate
%%
%%  Licence: CC0 1.0 Universal (public domain dedication)
%%           https://creativecommons.org/publicdomain/zero/1.0/
%%
%%  You normally do NOT need to edit this file. Set your data in config.tex
%%  and choose options in the \documentclass line of main.tex.
%% ===========================================================================
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{tfmthesis}[2026/10/15 v1.0.0 Master's Thesis class for Spanish universities]

%% ---------------------------------------------------------------------------
%%  1. Class options
%% ---------------------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=tfm, prefix=tfm@opt@}

% print        : two-sided layout for a printed copy (chapters open on the
%                right, blank versos, black links). Default: digital (one-sided).
\DeclareBoolOption[false]{print}
% font         : serif (Times-like) | sans (Helvetica/Arial-like) | modern (Latin Modern)
\DeclareStringOption[serif]{font}
% english      : british | american
\DeclareStringOption[british]{english}
% secondlanguage: spanish | catalan | valencian | galician | basque | none
%                 Language of the second abstract (Resumen/Resum/Resumo/Laburpena)
\DeclareStringOption[spanish]{secondlanguage}
% bibstyle     : any biblatex style, e.g. numeric-comp, ieee, apa, authoryear
\DeclareStringOption[numeric-comp]{bibstyle}
% final        : hides the guidance boxes and the to-do notes
\DeclareBoolOption[false]{final}
% review       : adds line numbers and a DRAFT watermark (for your supervisors)
\DeclareBoolOption[false]{review}
% uppercase    : chapter titles in CAPITALS (required by some schools)
\DeclareBoolOption[false]{uppercase}
% Anything else (10pt, 11pt, 12pt, openany...) is passed to the report class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessKeyvalOptions*

\iftfm@opt@print
  \PassOptionsToClass{twoside,openright}{report}
\else
  \PassOptionsToClass{oneside,openany}{report}
\fi
\LoadClass[a4paper,12pt]{report}

%% ---------------------------------------------------------------------------
%%  2. Engine, encoding, languages and fonts
%% ---------------------------------------------------------------------------
\RequirePackage{iftex}
\RequirePackage{etoolbox}
\RequirePackage{xstring}

% --- Languages ---------------------------------------------------------------
\def\tfm@babelsecond{}
\def\tfm@sl@abstract{}\def\tfm@sl@keywords{}\def\tfm@sl@thesistype{}
\IfStrEqCase{\tfm@opt@secondlanguage}{%
  {spanish}{\def\tfm@babelsecond{spanish}%
            \def\tfm@sl@abstract{Resumen}\def\tfm@sl@keywords{Palabras clave}%
            \def\tfm@sl@thesistype{Trabajo Fin de Máster}}%
  {catalan}{\def\tfm@babelsecond{catalan}%
            \def\tfm@sl@abstract{Resum}\def\tfm@sl@keywords{Paraules clau}%
            \def\tfm@sl@thesistype{Treball de Fi de Màster}}%
  {valencian}{\def\tfm@babelsecond{catalan}%
            \def\tfm@sl@abstract{Resum}\def\tfm@sl@keywords{Paraules clau}%
            \def\tfm@sl@thesistype{Treball de Fi de Màster}}%
  {galician}{\def\tfm@babelsecond{galician}%
            \def\tfm@sl@abstract{Resumo}\def\tfm@sl@keywords{Palabras chave}%
            \def\tfm@sl@thesistype{Traballo de Fin de Mestrado}}%
  {basque}{\def\tfm@babelsecond{basque}%
            \def\tfm@sl@abstract{Laburpena}\def\tfm@sl@keywords{Gako-hitzak}%
            \def\tfm@sl@thesistype{Master Amaierako Lana}}%
  {none}{}%
}[\ClassError{tfmthesis}{Unknown secondlanguage `\tfm@opt@secondlanguage'}%
   {Use spanish, catalan, valencian, galician, basque or none.}]

% Basque is loaded from babel's .ini locale (it has no classic .ldf file in
% some TeX distributions); the other languages use their .ldf files.
\ifdefempty{\tfm@babelsecond}
  {\PassOptionsToPackage{\tfm@opt@english}{babel}}
  {\ifdefstring{\tfm@babelsecond}{basque}
    {\PassOptionsToPackage{main=\tfm@opt@english}{babel}}
    {\PassOptionsToPackage{\tfm@babelsecond,main=\tfm@opt@english}{babel}}}
% Spanish shorthands (<, >, ", ~...) are disabled to avoid surprises
\ifdefstring{\tfm@babelsecond}{spanish}
  {\PassOptionsToPackage{es-noshorthands,es-nodecimaldot}{babel}}{}
\RequirePackage{babel}
\ifdefstring{\tfm@babelsecond}{basque}{\babelprovide[import]{basque}}{}

% --- Fonts -------------------------------------------------------------------
% amsmath must be loaded before newtxmath / unicode-math
\RequirePackage{amsmath}
\RequirePackage{mathtools}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \IfStrEqCase{\tfm@opt@font}{%
    {serif}{\RequirePackage{newtxtext}\RequirePackage{newtxmath}}%
    {sans}{\RequirePackage[scale=1]{tgheros}%
           \renewcommand{\familydefault}{\sfdefault}%
           \RequirePackage{newtxsf}}%
    {modern}{\RequirePackage{lmodern}}%
  }[\ClassError{tfmthesis}{Unknown font `\tfm@opt@font'}{Use serif, sans or modern.}]
  % Inconsolata: a clear monospaced font with bold, for code and file names
  \RequirePackage[scaled=0.95,varqu]{zi4}
\else
  \RequirePackage{unicode-math}
  \IfStrEqCase{\tfm@opt@font}{%
    {serif}{\setmainfont{TeX Gyre Termes}\setsansfont{TeX Gyre Heros}%
            \setmathfont{TeX Gyre Termes Math}}%
    {sans}{\setmainfont{TeX Gyre Heros}\setsansfont{TeX Gyre Heros}%
           \setmathfont{Latin Modern Math}}%
    {modern}{\setmainfont{Latin Modern Roman}\setsansfont{Latin Modern Sans}%
             \setmathfont{Latin Modern Math}}%
  }[\ClassError{tfmthesis}{Unknown font `\tfm@opt@font'}{Use serif, sans or modern.}]
  % Bold mathematics (e.g. \boldmath, bold numbers in siunitx tables)
  \IfStrEqCase{\tfm@opt@font}{%
    {serif}{\setmathfont{TeX Gyre Termes Math}[version=bold, FakeBold=2]}%
    {sans}{\setmathfont{Latin Modern Math}[version=bold, FakeBold=2]}%
    {modern}{\setmathfont{Latin Modern Math}[version=bold, FakeBold=2]}}
  \setmonofont{Inconsolatazi4}[Extension=.otf, UprightFont=*-Regular,
    BoldFont=*-Bold, Scale=0.95]
\fi
% Microtypography (character protrusion and font expansion) gives the best-looking
% paragraphs but slows down every compilation, so it is only enabled in final mode.
\iftfm@opt@final\RequirePackage{microtype}\fi

%% ---------------------------------------------------------------------------
%%  3. Page layout
%% ---------------------------------------------------------------------------
% Defaults follow the most common Spanish regulations: A4, 2.5 cm margins,
% 1.5 line spacing. Change them in config.tex with \geometry{...} if needed.
\RequirePackage[a4paper,margin=2.5cm,headheight=15pt,footskip=1.2cm]{geometry}
\iftfm@opt@print
  \geometry{inner=3cm,outer=2.5cm}
\fi
\RequirePackage{setspace}
\onehalfspacing
\setlength{\parindent}{1.25em}
\setlength{\parskip}{0.5\baselineskip plus 2pt minus 1pt}
\RequirePackage{emptypage} % blank pages in print mode carry no header/footer
\widowpenalty=10000
\clubpenalty=10000
% Extra stretch for paragraphs that could not be justified otherwise, which
% prevents lines from sticking out into the margin
\setlength{\emergencystretch}{2.5em}
\raggedbottom

%% ---------------------------------------------------------------------------
%%  4. Colours, graphics, tables and floats
%% ---------------------------------------------------------------------------
\RequirePackage[table,svgnames]{xcolor}
\definecolor{tfmaccent}{HTML}{1F4E79}   % redefine in config.tex
\colorlet{tfmgray}{black!55}
\RequirePackage{graphicx}
\graphicspath{{figures/}}
\RequirePackage{tikz}
\usetikzlibrary{positioning,arrows.meta,shapes.geometric,calc,fit}
\RequirePackage{pgfgantt}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{array}
% L: a tabularx X column with ragged-right text (no stretched spaces)
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\RequirePackage{siunitx}
\sisetup{group-separator={\,}, group-minimum-digits=4,
  reset-text-series=false, text-series-to-math=true, propagate-math-font=true}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup{font={small,stretch=1.1}, labelfont={bf,color=tfmaccent},
  labelsep=period, justification=justified, singlelinecheck=true, margin=0.5cm}
\captionsetup[table]{position=top, skip=6pt}
\captionsetup[figure]{skip=8pt}
\renewcommand{\arraystretch}{1.2}

%% ---------------------------------------------------------------------------
%%  5. Mathematics, lists, quotes and misc
%% ---------------------------------------------------------------------------
\ifPDFTeX
  % newtxmath / newtxsf already provide the AMS symbols
  \IfStrEqCase{\tfm@opt@font}{{modern}{\RequirePackage{amssymb}}}[]
  \RequirePackage{bm}
\else
  \providecommand{\bm}[1]{\symbfit{#1}}
\fi
\RequirePackage{enumitem}
\setlist{itemsep=0.2em, topsep=0.4em, parsep=0pt}
\RequirePackage{csquotes}
\RequirePackage{pdfpages}
\RequirePackage{ccicons}

% --- Algorithms ----------------------------------------------------------------
\RequirePackage[ruled,vlined,linesnumbered,algochapter]{algorithm2e}
\SetAlgoCaptionSeparator{.}
\SetAlCapFnt{\small\bfseries\color{tfmaccent}}
\SetAlCapNameFnt{\small}

% --- Source code -----------------------------------------------------------------
\RequirePackage{listings}
\definecolor{tfmcodebg}{HTML}{F6F8FA}
\definecolor{tfmcodecomment}{HTML}{6A737D}
\definecolor{tfmcodestring}{HTML}{0A6E31}
\definecolor{tfmcodekeyword}{HTML}{8B1E3F}
\lstdefinestyle{tfm}{
  basicstyle=\linespread{1.0}\small\ttfamily,
  backgroundcolor=\color{tfmcodebg},
  frame=leftline, framerule=2pt, rulecolor=\color{tfmaccent},
  xleftmargin=1.6em, framexleftmargin=0.5em, framesep=0pt,
  numbers=left, numberstyle=\scriptsize\color{tfmgray}, numbersep=1em,
  keywordstyle=\bfseries\color{tfmcodekeyword},
  commentstyle=\color{tfmcodecomment},
  stringstyle=\color{tfmcodestring},
  showstringspaces=false, showspaces=false, showtabs=false,
  tabsize=4, breaklines=true, breakatwhitespace=false,
  postbreak=\mbox{\textcolor{tfmgray}{$\hookrightarrow$}\space},
  captionpos=b, aboveskip=1em, belowskip=0.6em,
  upquote=true, columns=fullflexible, keepspaces=true,
  extendedchars=true,
  literate=
    {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
    {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
    {à}{{\`a}}1 {è}{{\`e}}1 {ò}{{\`o}}1 {À}{{\`A}}1 {È}{{\`E}}1 {Ò}{{\`O}}1
    {ñ}{{\~n}}1 {Ñ}{{\~N}}1 {ü}{{\"u}}1 {Ü}{{\"U}}1 {ï}{{\"i}}1
    {ç}{{\c c}}1 {Ç}{{\c C}}1 {·}{{\textperiodcentered}}1
    {¿}{{?`}}1 {¡}{{!`}}1 {€}{{\texteuro}}1 {±}{{$\pm$}}1 {≤}{{$\leq$}}1 {≥}{{$\geq$}}1 {×}{{$\times$}}1 {º}{{\textordmasculine}}1 {ª}{{\textordfeminine}}1
}
\lstset{style=tfm}

%% ---------------------------------------------------------------------------
%%  6. To-do notes, guidance boxes, review mode
%% ---------------------------------------------------------------------------
\iftfm@opt@final
  \RequirePackage[disable]{todonotes}
\else
  \RequirePackage[colorinlistoftodos,textsize=footnotesize,
    color=orange!25,bordercolor=orange!70!black]{todonotes}
\fi
\setlength{\marginparwidth}{2cm}

\RequirePackage[most]{tcolorbox}
\RequirePackage{comment}
\iftfm@opt@final
  % In final mode every guidance box disappears from the PDF
  \excludecomment{guidance}
\else
  \newtcolorbox{guidance}{enhanced,
    colback=tfmaccent!4, colframe=tfmaccent!60, boxrule=0.6pt,
    leftrule=3pt, arc=1.5pt, left=8pt, right=8pt, top=4pt, bottom=4pt,
    fontupper=\small\setstretch{1.1}\setlength{\parindent}{0pt}\setlength{\parskip}{0.4em},
    parbox=false,
    title={\small\bfseries Template guidance},
    coltitle=tfmaccent!80!black,
    attach title to upper={\par\smallskip}}
\fi

\iftfm@opt@review
  \RequirePackage{lineno}
  \renewcommand{\linenumberfont}{\normalfont\tiny\color{tfmgray}}
  % Line numbers start right after the cover (see \makecover)
  \RequirePackage{draftwatermark}
  \DraftwatermarkOptions{text={DRAFT}, fontsize=3.2cm, color=black!7, angle=45}
\fi

%% ---------------------------------------------------------------------------
%%  7. Thesis metadata (set in config.tex)
%% ---------------------------------------------------------------------------
\newcommand*{\tfm@field}[2]{%
  \expandafter\newcommand\csname #1\endcsname[1]{\expandafter\gdef\csname tfm@#2\endcsname{##1}}%
  \expandafter\gdef\csname tfm@#2\endcsname{}}
\tfm@field{ThesisTitle}{title}
\tfm@field{ThesisSubtitle}{subtitle}
\tfm@field{ThesisShortTitle}{shorttitle}
\tfm@field{ThesisTitleSecondLanguage}{titlesl}
\tfm@field{ThesisAuthor}{author}
\tfm@field{AuthorEmail}{authoremail}
\tfm@field{AuthorIDNumber}{authorid}
\tfm@field{University}{university}
\tfm@field{Faculty}{faculty}
\tfm@field{Department}{department}
\tfm@field{Degree}{degree}
\tfm@field{City}{city}
\tfm@field{SubmissionDate}{date}
\tfm@field{AcademicYear}{academicyear}
\tfm@field{DefenceSession}{session}
\tfm@field{Keywords}{keywords}
\tfm@field{KeywordsSecondLanguage}{keywordssl}
\tfm@field{UniversityLogo}{logofile}
\tfm@field{SecondaryLogo}{logobfile}
\tfm@field{OfficialCover}{officialcover}
\tfm@field{ThesisLicence}{licence}
\tfm@field{ThesisType}{thesistype}
\tfm@field{ThesisTypeSecondLanguage}{thesistypesl}
\tfm@field{AbstractTitleSecondLanguage}{abstractsl}
\tfm@field{KeywordsLabelSecondLanguage}{keywordslabelsl}
\tfm@field{FooterText}{footertext}

% Defaults (overridden by config.tex)
\ThesisType{Master's Thesis}
\expandafter\ThesisTypeSecondLanguage\expandafter{\tfm@sl@thesistype}
\expandafter\AbstractTitleSecondLanguage\expandafter{\tfm@sl@abstract}
\expandafter\KeywordsLabelSecondLanguage\expandafter{\tfm@sl@keywords}
\ThesisLicence{all-rights-reserved}
\SubmissionDate{\today}

% Supervisors: \Supervisor[Role]{Full name}{Affiliation}. Repeat as needed.
\newcounter{tfm@supervisors}
\def\tfm@supervisorlist{}
\newcommand{\Supervisor}[3][Supervisor]{%
  \stepcounter{tfm@supervisors}%
  \expandafter\gdef\csname tfm@sup@role@\arabic{tfm@supervisors}\endcsname{#1}%
  \expandafter\gdef\csname tfm@sup@name@\arabic{tfm@supervisors}\endcsname{#2}%
  \expandafter\gdef\csname tfm@sup@aff@\arabic{tfm@supervisors}\endcsname{#3}}
\newcounter{tfm@i}
\newcommand{\tfm@forsupervisors}[1]{% #1 uses \tfm@role, \tfm@name, \tfm@aff
  \setcounter{tfm@i}{0}%
  \loop\ifnum\value{tfm@i}<\value{tfm@supervisors}%
    \stepcounter{tfm@i}%
    \letcs{\tfm@role}{tfm@sup@role@\arabic{tfm@i}}%
    \letcs{\tfm@name}{tfm@sup@name@\arabic{tfm@i}}%
    \letcs{\tfm@aff}{tfm@sup@aff@\arabic{tfm@i}}%
    #1%
  \repeat}
% Comma-separated list of supervisor names: "A", "A and B", "A, B and C"
\newcommand{\tfm@supervisornames}{%
  \setcounter{tfm@i}{0}%
  \loop\ifnum\value{tfm@i}<\value{tfm@supervisors}%
    \stepcounter{tfm@i}%
    \ifnum\value{tfm@i}>1
      \ifnum\value{tfm@i}=\value{tfm@supervisors}\ and\ \else,\ \fi
    \fi
    \csname tfm@sup@name@\arabic{tfm@i}\endcsname
  \repeat}

% Public accessors, handy inside your own text: \thesistitle, \thesisauthor...
\newcommand{\thesistitle}{\tfm@title}
\newcommand{\thesisshorttitle}{\tfm@shorttitle}
\newcommand{\thesisauthor}{\tfm@author}
\newcommand{\thesisdegree}{\tfm@degree}
\newcommand{\thesisuniversity}{\tfm@university}
\newcommand{\thesisfaculty}{\tfm@faculty}
\newcommand{\thesistype}{\tfm@thesistype}
\newcommand{\thesisdate}{\tfm@date}
\newcommand{\thesissupervisors}{\tfm@supervisornames}

% Optional pages (toggle them in config.tex with \settoggle{...}{true|false})
\newtoggle{tfmLicencePage}\toggletrue{tfmLicencePage}
\newtoggle{tfmApprovalPage}\togglefalse{tfmApprovalPage}
\newtoggle{tfmOriginalityPage}\toggletrue{tfmOriginalityPage}
% The user guide chapter is only included when compiling template-guide.tex,
% which defines \TemplateGuide before loading main.tex
\newtoggle{tfmTemplateGuide}
\ifdefined\TemplateGuide\toggletrue{tfmTemplateGuide}\else\togglefalse{tfmTemplateGuide}\fi

%% ---------------------------------------------------------------------------
%%  8. Headings
%% ---------------------------------------------------------------------------
\RequirePackage[explicit]{titlesec}
\iftfm@opt@uppercase
  \newcommand{\tfm@chaptercase}[1]{\MakeUppercase{#1}}
\else
  \newcommand{\tfm@chaptercase}[1]{#1}
\fi
\titleformat{\chapter}[display]
  {\normalfont\raggedright}
  {\large\bfseries\color{tfmaccent}\MakeUppercase{\chaptertitlename}~\thechapter}
  {0.4em}
  {\Huge\bfseries\setstretch{1.0}\tfm@chaptercase{#1}}
  [\vspace{0.6em}{\color{tfmaccent}\titlerule[1.2pt]}]
\titleformat{name=\chapter,numberless}[display]
  {\normalfont\raggedright}
  {}
  {0pt}
  {\Huge\bfseries\setstretch{1.0}\tfm@chaptercase{#1}}
  [\vspace{0.6em}{\color{tfmaccent}\titlerule[1.2pt]}]
\titlespacing*{\chapter}{0pt}{0pt}{2.2em}
\titleformat{\section}
  {\normalfont\Large\bfseries\raggedright}{\textcolor{tfmaccent}{\thesection}}{0.8em}{#1}
\titleformat{\subsection}
  {\normalfont\large\bfseries\raggedright}{\textcolor{tfmaccent}{\thesubsection}}{0.8em}{#1}
\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries\raggedright}{\textcolor{tfmaccent}{\thesubsubsection}}{0.8em}{#1}
\titleformat{\paragraph}[runin]
  {\normalfont\normalsize\bfseries}{}{0pt}{#1.}
\titlespacing*{\section}{0pt}{1.6em plus 0.4em minus 0.2em}{0.6em}
\titlespacing*{\subsection}{0pt}{1.3em plus 0.3em minus 0.2em}{0.5em}
\titlespacing*{\subsubsection}{0pt}{1.1em plus 0.3em minus 0.2em}{0.4em}
\titlespacing*{\paragraph}{0pt}{0.8em}{0.6em}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% Table of contents
\RequirePackage{titletoc}
\titlecontents{chapter}[1.6em]{\addvspace{0.7em}\bfseries}
  {\contentslabel[\color{tfmaccent}\thecontentslabel]{1.6em}}{\hspace*{-1.6em}}
  {\hfill\contentspage}[\addvspace{0.1em}]

\renewcommand{\@pnumwidth}{2.4em}
\renewcommand{\@tocrmarg}{3.2em}

%% ---------------------------------------------------------------------------
%%  9. Headers and footers
%% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\ifnum\value{chapter}>0 \thechapter.\ \fi#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\newcommand{\tfm@headfont}{\footnotesize\color{tfmgray}}
\fancyhf{}
\iftfm@opt@print
  \fancyhead[LE]{\tfm@headfont\nouppercase{\leftmark}}
  \fancyhead[RO]{\tfm@headfont\tfm@shorttitle}
  \fancyfoot[RE,LO]{\tfm@headfont\tfm@footertext}
  \fancyfoot[LE,RO]{\small\thepage}
\else
  \fancyhead[L]{\tfm@headfont\nouppercase{\leftmark}}
  \fancyhead[R]{\tfm@headfont\tfm@shorttitle}
  \fancyfoot[L]{\tfm@headfont\tfm@footertext}
  \fancyfoot[R]{\small\thepage}
\fi
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\renewcommand{\headrule}{{\color{black!25}\hrule height\headrulewidth width\headwidth\vskip-\headrulewidth}}
\renewcommand{\footrule}{{\color{black!25}\vskip-\footruleskip\vskip-\footrulewidth
  \hrule height\footrulewidth width\headwidth\vskip\footruleskip}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \iftfm@opt@print\fancyfoot[LE,RO]{\small\thepage}\else\fancyfoot[R]{\small\thepage}\fi}

%% ---------------------------------------------------------------------------
%% 10. Bibliography, acronyms, hyperlinks and cross-references
%% ---------------------------------------------------------------------------
\edef\tfm@loadbiblatex{\noexpand\RequirePackage[backend=biber,
  style=\tfm@opt@bibstyle, doi=true, url=true, isbn=false]{biblatex}}
\tfm@loadbiblatex
% APA has its own strict rules; author-year styles keep their alphabetical
% sorting; numeric styles list the references in order of citation.
\newcommand{\tfm@authoryearopts}{\ExecuteBibliographyOptions{maxbibnames=10,
  giveninits=true, uniquename=init}}
\IfStrEqCase{\tfm@opt@bibstyle}{%
  {apa}{}%
  {authoryear}{\tfm@authoryearopts}{authoryear-comp}{\tfm@authoryearopts}%
  {authoryear-ibid}{\tfm@authoryearopts}{authoryear-icomp}{\tfm@authoryearopts}%
  {authortitle}{\tfm@authoryearopts}{chicago-authordate}{}}%
  [\tfm@authoryearopts\ExecuteBibliographyOptions{sorting=none}]
\setlength{\bibitemsep}{0.35\baselineskip}
\AtBeginBibliography{\small\setstretch{1.1}}

\RequirePackage[acronym,nomain,nonumberlist,nopostdot,toc=false,translate=false]{glossaries}
\setacronymstyle{long-short}
\makenoidxglossaries

\RequirePackage{xurl}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\iftfm@opt@print
  \hypersetup{hidelinks}
\else
  \hypersetup{colorlinks=true, linkcolor=tfmaccent, citecolor=tfmaccent!70!green!60!black,
    urlcolor=tfmaccent!70!cyan!80!black, filecolor=tfmaccent}
\fi
\hypersetup{bookmarksnumbered=true, bookmarksopen=true, bookmarksopenlevel=1,
  breaklinks=true, pdfdisplaydoctitle=true, pdfstartview=Fit, pdfpagemode=UseOutlines}
\AtBeginDocument{%
  \hypersetup{pdftitle={\tfm@title}, pdfauthor={\tfm@author},
    pdfsubject={\tfm@thesistype\ifdefempty{\tfm@degree}{}{ -- \tfm@degree}},
    pdfkeywords={\tfm@keywords}, pdfcreator={LaTeX with tfmthesis.cls}}%
  \ifdefempty{\tfm@shorttitle}{\global\let\tfm@shorttitle\tfm@title}{}%
  \ifdefempty{\tfm@footertext}{\global\let\tfm@footertext\tfm@university}{}%
}
\RequirePackage[capitalise,nameinlink,noabbrev]{cleveref}
\crefname{listing}{Listing}{Listings}
\Crefname{listing}{Listing}{Listings}
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}
\crefname{algocf}{Algorithm}{Algorithms}
\Crefname{algocf}{Algorithm}{Algorithms}
\crefname{equation}{Equation}{Equations}
\creflabelformat{equation}{#2(#1)#3}

%% ---------------------------------------------------------------------------
%% 11. Document structure helpers
%% ---------------------------------------------------------------------------
\newcommand{\frontmatter}{\cleardoublepage\pagenumbering{roman}}
\newcommand{\mainmatter}{\cleardoublepage\pagenumbering{arabic}}
\newcommand{\backmatter}{\cleardoublepage}

% Unnumbered chapter listed in the table of contents and in the headers
\newcommand{\frontchapter}[1]{%
  \chapter*{#1}%
  \phantomsection\addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}}

% Lists of figures, tables... that also appear in the table of contents.
% They are typeset with tighter line spacing and black (but clickable) entries.
\newcommand{\tfm@listin}[2]{\cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{#1}%
  \begingroup\setstretch{1.15}\hypersetup{linkcolor=black}#2\endgroup}
\newcommand{\listoffiguresintoc}{\tfm@listin{\listfigurename}{\listoffigures}}
\newcommand{\listoftablesintoc}{\tfm@listin{\listtablename}{\listoftables}}
\newcommand{\listofalgorithmsintoc}{\tfm@listin{List of Algorithms}{\listofalgorithms}}
\newcommand{\listoflistingsintoc}{\tfm@listin{\lstlistlistingname}{\lstlistoflistings}}
\newcommand{\listofacronymsintoc}{\cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{List of Acronyms}%
  \printnoidxglossary[type=\acronymtype,title={List of Acronyms}]}
\newcommand{\tableofcontentsintoc}{\cleardoublepage
  \pdfbookmark[0]{\contentsname}{toc}%
  \begingroup\setstretch{1.15}\hypersetup{linkcolor=black}\tableofcontents\endgroup}
\newcommand{\bibliographyintoc}{\cleardoublepage
  \printbibliography[heading=bibintoc,title={References}]}

\renewcommand{\lstlistingname}{Listing}
\renewcommand{\lstlistlistingname}{List of Listings}
\renewcommand{\listalgorithmcfname}{List of Algorithms}
\renewcommand{\glsnamefont}[1]{\textbf{#1}}

%% ---------------------------------------------------------------------------
%% 12. Logos and cover page
%% ---------------------------------------------------------------------------
% Draws the logo if the file exists; otherwise a neutral placeholder box
\newcommand{\tfm@drawlogo}[2]{% #1 macro holding the file, #2 height
  \ifdefempty{#1}{}{%
    \IfFileExists{#1}
      {\includegraphics[height=#2,keepaspectratio]{#1}}
      {\begin{tikzpicture}
         \node[draw=tfmaccent!60, dashed, rounded corners=2pt, minimum width=1.6*#2,
           minimum height=#2, align=center, text=tfmaccent!80, font=\scriptsize\sffamily]
           {University\\logo};
       \end{tikzpicture}}}}

\newcommand{\tfm@coverline}[2]{% label, value
  \ifstrempty{#2}{}{{\color{tfmgray}\small\MakeUppercase{#1}}\\[0.15em]{\large #2}\par\medskip}}

\newcommand{\makecover}{%
  \begingroup
  \ifdefempty{\tfm@officialcover}{}{%
    \includepdf[pages=1]{\tfm@officialcover}}%
  \thispagestyle{empty}%
  \setstretch{1.15}%
  \noindent
  \begin{minipage}[t][\textheight][t]{\textwidth}
    \begin{tikzpicture}[remember picture, overlay]
      \fill[tfmaccent] (current page.north west) rectangle
        ([xshift=0.9cm]current page.south west);
      \fill[tfmaccent!35] ([xshift=0.9cm]current page.north west) rectangle
        ([xshift=1.05cm]current page.south west);
    \end{tikzpicture}%
    \tfm@drawlogo{\tfm@logofile}{2.3cm}\hfill\tfm@drawlogo{\tfm@logobfile}{2.3cm}\par
    \vspace{1.2cm}
    {\Large\bfseries\tfm@university\par}
    \vspace{0.25em}
    \ifdefempty{\tfm@faculty}{}{{\large\tfm@faculty\par}}
    \vspace{0.25em}
    \ifdefempty{\tfm@degree}{}{{\large\color{tfmgray}\tfm@degree\par}}
    \vfill
    {\color{tfmaccent}\large\bfseries\MakeUppercase{\tfm@thesistype}%
      \ifdefempty{\tfm@thesistypesl}{}{\ \textcolor{tfmaccent!45}{|}\ %
        \textcolor{tfmaccent!75}{\mdseries\tfm@thesistypesl}}\par}
    \vspace{0.6em}
    {\color{tfmaccent}\rule{0.18\textwidth}{2pt}\par}
    \vspace{0.9em}
    {\fontsize{25}{31}\selectfont\bfseries\raggedright\tfm@title\par}
    \ifdefempty{\tfm@subtitle}{}{\vspace{0.6em}{\Large\raggedright\tfm@subtitle\par}}
    \ifdefempty{\tfm@titlesl}{}{\vspace{0.9em}%
      {\large\itshape\color{tfmgray}\raggedright
       \ifdefempty{\tfm@babelsecond}{\tfm@titlesl}%
         {\foreignlanguage{\tfm@babelsecond}{\tfm@titlesl}}\par}}
    \vfill
    \begin{minipage}[t]{0.6\textwidth}
      \raggedright
      \tfm@coverline{Author}{\tfm@author}%
      \tfm@forsupervisors{\tfm@coverline{\tfm@role}{\tfm@name}%
        \vspace{-0.6em}{\small\color{tfmgray}\tfm@aff\par}\medskip}%
    \end{minipage}\hfill
    \begin{minipage}[t]{0.36\textwidth}
      \raggedleft
      \ifdefempty{\tfm@department}{}{{\color{tfmgray}\small\MakeUppercase{Department}}\\[0.15em]
        {\large\tfm@department}\par\medskip}
      \ifdefempty{\tfm@academicyear}{}{{\color{tfmgray}\small\MakeUppercase{Academic year}}\\[0.15em]
        {\large\tfm@academicyear}\par\medskip}
      \ifdefempty{\tfm@session}{}{{\color{tfmgray}\small\MakeUppercase{Session}}\\[0.15em]
        {\large\tfm@session}\par}
    \end{minipage}\par
    \vspace{1cm}
    {\color{tfmaccent}\rule{\textwidth}{0.6pt}\par}
    \vspace{0.3em}
    {\small\color{tfmgray}\ifdefempty{\tfm@city}{}{\tfm@city,\ }\tfm@date\par}
  \end{minipage}%
  \endgroup
  \clearpage
  \iftfm@opt@review\linenumbers\fi}

%% ---------------------------------------------------------------------------
%% 13. Licence / copyright page
%% ---------------------------------------------------------------------------
\newcommand{\tfm@licencetext}{%
  \IfStrEqCase{\tfm@licence}{%
    {all-rights-reserved}{\textcopyright\ \the\year\ \tfm@author. All rights reserved.\par
      No part of this work may be reproduced without the prior written permission
      of the author, except as permitted by the applicable intellectual property law.}%
    {by}{{\Large\ccby}\par\medskip
      This work is licensed under a Creative Commons Attribution 4.0 International
      licence (CC BY 4.0). \url{https://creativecommons.org/licenses/by/4.0/}}%
    {by-sa}{{\Large\ccbysa}\par\medskip
      This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
      International licence (CC BY-SA 4.0). \url{https://creativecommons.org/licenses/by-sa/4.0/}}%
    {by-nc}{{\Large\ccbync}\par\medskip
      This work is licensed under a Creative Commons Attribution-NonCommercial 4.0
      International licence (CC BY-NC 4.0). \url{https://creativecommons.org/licenses/by-nc/4.0/}}%
    {by-nc-sa}{{\Large\ccbyncsa}\par\medskip
      This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0
      International licence (CC BY-NC-SA 4.0). \url{https://creativecommons.org/licenses/by-nc-sa/4.0/}}%
    {by-nd}{{\Large\ccbynd}\par\medskip
      This work is licensed under a Creative Commons Attribution-NoDerivatives 4.0
      International licence (CC BY-ND 4.0). \url{https://creativecommons.org/licenses/by-nd/4.0/}}%
    {by-nc-nd}{{\Large\ccbyncnd}\par\medskip
      This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0
      International licence (CC BY-NC-ND 4.0). \url{https://creativecommons.org/licenses/by-nc-nd/4.0/}}%
  }[\tfm@licence]}

\newcommand{\makelicencepage}{%
  \iftoggle{tfmLicencePage}{%
    \clearpage\thispagestyle{empty}%
    \vspace*{\fill}
    \begingroup\small\setstretch{1.2}\setlength{\parindent}{0pt}\setlength{\parskip}{0.6em}%
    \textbf{\tfm@title}\ifdefempty{\tfm@subtitle}{}{: \tfm@subtitle}\par
    \tfm@thesistype\ifdefempty{\tfm@degree}{}{, \tfm@degree}\ifdefempty{\tfm@university}{}{,
      \tfm@university}\ifdefempty{\tfm@academicyear}{}{, \tfm@academicyear}.\par
    \ifdefempty{\tfm@authoremail}{\tfm@author\par}{\tfm@author\ -- \href{mailto:\tfm@authoremail}{\nolinkurl{\tfm@authoremail}}\par}
    \bigskip
    \tfm@licencetext\par
    \endgroup
    \clearpage}{}}

%% ---------------------------------------------------------------------------
%% 14. Declarations and signatures
%% ---------------------------------------------------------------------------
\newcommand{\tfm@signature}[2]{% name, role
  \begin{minipage}[t]{0.45\textwidth}\centering
    \vspace*{2.2cm}
    \rule{0.85\linewidth}{0.4pt}\par
    {\small #1\par\color{tfmgray}#2}
  \end{minipage}}
\newcommand{\tfm@placedate}{%
  \ifdefempty{\tfm@city}{}{\tfm@city,\ }\tfm@date}

\newcommand{\makeoriginalitypage}{%
  \iftoggle{tfmOriginalityPage}{%
    \frontchapter{Declaration of Originality}
    \thispagestyle{plain}%
    I, \textbf{\tfm@author}\ifdefempty{\tfm@authorid}{}{, with identity document number
    \tfm@authorid}, student of the \tfm@degree\ at \tfm@university, declare that:
    \begin{enumerate}
      \item This \tfm@thesistype, entitled \emph{\tfm@title}, is my own original work
            and has been carried out under the supervision of \tfm@supervisornames.
      \item It has not been submitted, in whole or in part, for any other degree or
            qualification at this or any other university.
      \item All the sources used have been properly cited and acknowledged, and every
            figure, table or text taken from other works has been reproduced with
            permission or under the terms of its licence.
      \item Any use of generative artificial intelligence tools has been declared in
            this document in accordance with the regulations of my university.
      \item I am aware that plagiarism and any other form of academic dishonesty may
            lead to the failure of this \tfm@thesistype\ and to disciplinary measures.
    \end{enumerate}
    \par\bigskip
    \begin{center}\tfm@placedate\end{center}
    \begin{center}\tfm@signature{\tfm@author}{Author}\end{center}
    \cleardoublepage}{}}

\newcommand{\makeapprovalpage}{%
  \iftoggle{tfmApprovalPage}{%
    \frontchapter{Supervisor's Approval}
    \thispagestyle{plain}%
    \tfm@supervisornames,
    \ifnum\value{tfm@supervisors}>1 supervisors \else supervisor \fi
    of the \tfm@thesistype\ entitled \emph{\tfm@title}, carried out by
    \textbf{\tfm@author}\ within the \tfm@degree, hereby
    \ifnum\value{tfm@supervisors}>1 authorise \else authorises \fi
    its submission for public defence and assessment
    \ifdefempty{\tfm@faculty}{at \tfm@university}{at the \tfm@faculty, \tfm@university}.
    \par\bigskip
    \begin{center}\tfm@placedate\end{center}
    \begin{center}%
      \tfm@forsupervisors{\tfm@signature{\tfm@name}{\tfm@role}\hfill}%
    \end{center}
    \cleardoublepage}{}}

%% ---------------------------------------------------------------------------
%% 15. Abstracts
%% ---------------------------------------------------------------------------
\newenvironment{abstractpage}{%
  \frontchapter{Abstract}}{%
  \ifdefempty{\tfm@keywords}{}{\par\bigskip\noindent\textbf{Keywords:} \tfm@keywords}%
  \cleardoublepage}
\newenvironment{abstractsecondlanguage}{%
  \ifdefempty{\tfm@babelsecond}{\ClassWarning{tfmthesis}{secondlanguage=none,
    but the abstractsecondlanguage environment is used}}{}%
  \frontchapter{\tfm@abstractsl}%
  \ifdefempty{\tfm@titlesl}{}{\noindent\textit{\tfm@titlesl}\par\medskip}%
  \ifdefempty{\tfm@babelsecond}{\begin{otherlanguage}{\tfm@opt@english}}%
    {\begin{otherlanguage}{\tfm@babelsecond}}}{%
  \ifdefempty{\tfm@keywordssl}{}{\par\bigskip\noindent\textbf{\tfm@keywordslabelsl:}
    \tfm@keywordssl}%
  \end{otherlanguage}\cleardoublepage}

%% ---------------------------------------------------------------------------
%% 16. Sustainable Development Goals (SDG) table helper
%% ---------------------------------------------------------------------------
% \sdg{number}{name}{level}  with level = H (high), M (medium), L (low), N (not applicable)
\newcommand{\tfm@sdgmark}[2]{\ifstrequal{#1}{#2}{\textcolor{tfmaccent}{$\checkmark$}}{}}
\newcommand{\sdg}[3]{\textbf{SDG #1.} #2 & \tfm@sdgmark{#3}{H} & \tfm@sdgmark{#3}{M}
  & \tfm@sdgmark{#3}{L} & \tfm@sdgmark{#3}{N}\\}

%% ---------------------------------------------------------------------------
%% 17. Sanity checks
%% ---------------------------------------------------------------------------
\AtBeginDocument{%
  \ifdefempty{\tfm@title}{\ClassWarningNoLine{tfmthesis}{No \string\ThesisTitle\space set in config.tex}}{}%
  \ifdefempty{\tfm@author}{\ClassWarningNoLine{tfmthesis}{No \string\ThesisAuthor\space set in config.tex}}{}%
  \ifnum\value{tfm@supervisors}=0
    \ClassWarningNoLine{tfmthesis}{No \string\Supervisor\space set in config.tex}\fi
}
\endinput
