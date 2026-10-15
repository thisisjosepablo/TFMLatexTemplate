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
%%  It uses exactly the same packages as that template: babel, inputenc,
%%  fontenc, geometry, setspace, fancyhdr, helvet, wallpaper, textpos,
%%  etoolbox, natbib, csquotes, hyperref, booktabs, algorithm2e, listings and
%%  xcolor. Everything else is plain LaTeX.
%%
%%  Licence: CC0 1.0 Universal (public domain dedication)
%%           https://creativecommons.org/publicdomain/zero/1.0/
%%
%%  You normally do NOT need to edit this file. Set your data in config.tex
%%  and choose options in the \documentclass line of main.tex.
%% ===========================================================================
\NeedsTeXFormat{LaTeX2e}[2022/11/01]
\ProvidesClass{tfmthesis}[2026/10/15 v2.0.0 Master's Thesis class for Spanish universities]

%% ---------------------------------------------------------------------------
%%  1. Class options
%% ---------------------------------------------------------------------------
\newif\iftfm@print      % two-sided layout for a printed copy
\newif\iftfm@final      % hide guidance boxes and to-do notes
\newif\iftfm@uppercase  % chapter titles in capitals
\def\tfm@font{sans}               % sans (Helvetica, like Arial) | serif (Computer Modern)
\def\tfm@secondlanguage{spanish}  % spanish | catalan | valencian | galician | basque | none
\def\tfm@english{british}         % british | american
\def\tfm@bibstyle{numeric}        % numeric | authoryear
\def\tfm@size{12pt}
\DeclareKeys[tfm]{
  print.if            = tfm@print,
  final.if            = tfm@final,
  uppercase.if        = tfm@uppercase,
  font.store          = \tfm@font,
  secondlanguage.store= \tfm@secondlanguage,
  english.store       = \tfm@english,
  bibstyle.store      = \tfm@bibstyle,
  10pt.code           = \def\tfm@size{10pt},
  11pt.code           = \def\tfm@size{11pt},
  12pt.code           = \def\tfm@size{12pt},
}
\DeclareUnknownKeyHandler[tfm]{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessKeyOptions[tfm]

\iftfm@print
  \PassOptionsToClass{twoside,openright}{report}
\else
  \PassOptionsToClass{oneside,openany}{report}
\fi
\edef\tfm@loadclass{\noexpand\LoadClass[a4paper,\tfm@size]{report}}
\tfm@loadclass

%% ---------------------------------------------------------------------------
%%  2. Languages and fonts
%% ---------------------------------------------------------------------------
\RequirePackage{etoolbox}

% Second language: abstract title, keywords label and name of the work
\def\tfm@babelsecond{}\def\tfm@sl@abstract{}\def\tfm@sl@keywords{}\def\tfm@sl@thesistype{}
\ifdefstring{\tfm@secondlanguage}{spanish}{%
  \def\tfm@babelsecond{spanish}\def\tfm@sl@abstract{Resumen}%
  \def\tfm@sl@keywords{Palabras clave}\def\tfm@sl@thesistype{Trabajo Fin de Máster}}{}
\ifdefstring{\tfm@secondlanguage}{catalan}{%
  \def\tfm@babelsecond{catalan}\def\tfm@sl@abstract{Resum}%
  \def\tfm@sl@keywords{Paraules clau}\def\tfm@sl@thesistype{Treball de Fi de Màster}}{}
\ifdefstring{\tfm@secondlanguage}{valencian}{%
  \def\tfm@babelsecond{catalan}\def\tfm@sl@abstract{Resum}%
  \def\tfm@sl@keywords{Paraules clau}\def\tfm@sl@thesistype{Treball de Fi de Màster}}{}
\ifdefstring{\tfm@secondlanguage}{galician}{%
  \def\tfm@babelsecond{galician}\def\tfm@sl@abstract{Resumo}%
  \def\tfm@sl@keywords{Palabras chave}\def\tfm@sl@thesistype{Traballo de Fin de Mestrado}}{}
\ifdefstring{\tfm@secondlanguage}{basque}{%
  \def\tfm@babelsecond{basque}\def\tfm@sl@abstract{Laburpena}%
  \def\tfm@sl@keywords{Gako-hitzak}\def\tfm@sl@thesistype{Master Amaierako Lana}}{}

% Basque is loaded from babel's .ini locale (some distributions have no .ldf);
% Spanish shorthands are disabled to avoid surprises.
\ifdefempty{\tfm@babelsecond}
  {\PassOptionsToPackage{\tfm@english}{babel}}
  {\ifdefstring{\tfm@babelsecond}{basque}
    {\PassOptionsToPackage{main=\tfm@english}{babel}}
    {\PassOptionsToPackage{\tfm@babelsecond,main=\tfm@english}{babel}}}
\ifdefstring{\tfm@babelsecond}{spanish}
  {\PassOptionsToPackage{es-noshorthands,es-nodecimaldot}{babel}}{}
\RequirePackage{babel}
\ifdefstring{\tfm@babelsecond}{basque}{\babelprovide[import]{basque}}{}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\ifdefstring{\tfm@font}{sans}{%
  \RequirePackage{helvet}% Helvetica: same metrics as Arial
  \renewcommand{\familydefault}{\sfdefault}}{}

%% ---------------------------------------------------------------------------
%%  3. Page layout
%% ---------------------------------------------------------------------------
% A4, 2.5 cm margins and 1.5 line spacing, as in the original template and in
% most Spanish regulations. Change them in config.tex with \geometry{...}.
\RequirePackage[a4paper,margin=2.5cm,headheight=15pt]{geometry}
\iftfm@print\geometry{inner=3cm,outer=2.5cm}\fi
\RequirePackage{setspace}
\onehalfspacing
\setlength{\parindent}{1.25em}
\setlength{\parskip}{0.5\baselineskip plus 2pt minus 1pt}
\widowpenalty=10000
\clubpenalty=10000
\setlength{\emergencystretch}{2.5em}
\raggedbottom
% Blank pages added before a new chapter (print mode) carry no header/footer
\renewcommand{\cleardoublepage}{\clearpage\if@twoside\ifodd\c@page\else
  \hbox{}\thispagestyle{empty}\newpage\fi\fi}

%% ---------------------------------------------------------------------------
%%  4. Colours, graphics, tables, algorithms and code
%% ---------------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{tfmaccent}{HTML}{1F4E79}   % redefine it in config.tex
\colorlet{tfmgray}{black!55}
\RequirePackage{wallpaper}               % official PDF cover (also loads graphicx)
\RequirePackage[absolute,overlay]{textpos}
\graphicspath{{figures/}}
\RequirePackage{booktabs}

\RequirePackage[ruled,vlined,linesnumbered,algochapter]{algorithm2e}
\SetAlgoCaptionSeparator{.}
\SetAlCapFnt{\small\bfseries\color{tfmaccent}}
\SetAlCapNameFnt{\small}

\RequirePackage{listings}
\definecolor{tfmcodebg}{HTML}{F6F8FA}
\definecolor{tfmcodecomment}{HTML}{6A737D}
\definecolor{tfmcodestring}{HTML}{0A6E31}
\definecolor{tfmcodekeyword}{HTML}{8B1E3F}
\lstdefinestyle{tfm}{
  basicstyle=\linespread{1.0}\small\ttfamily,
  backgroundcolor=\color{tfmcodebg},
  frame=leftline, framerule=2pt, rulecolor=\color{tfmaccent},
  xleftmargin=1.6em, framexleftmargin=0.5em,
  numbers=left, numberstyle=\scriptsize\color{tfmgray}, numbersep=1em,
  keywordstyle=\bfseries\color{tfmcodekeyword},
  commentstyle=\color{tfmcodecomment},
  stringstyle=\color{tfmcodestring},
  showstringspaces=false, showspaces=false, showtabs=false,
  tabsize=4, breaklines=true, breakatwhitespace=false,
  captionpos=b, aboveskip=1em, belowskip=0.6em,
  upquote=true, columns=fullflexible, keepspaces=true, extendedchars=true,
  literate=
    {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
    {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
    {à}{{\`a}}1 {è}{{\`e}}1 {ò}{{\`o}}1 {À}{{\`A}}1 {È}{{\`E}}1 {Ò}{{\`O}}1
    {ñ}{{\~n}}1 {Ñ}{{\~N}}1 {ü}{{\"u}}1 {Ü}{{\"U}}1 {ï}{{\"i}}1
    {ç}{{\c c}}1 {Ç}{{\c C}}1 {·}{{\textperiodcentered}}1
    {¿}{{?`}}1 {¡}{{!`}}1 {€}{{\texteuro}}1 {º}{{\textordmasculine}}1
    {ª}{{\textordfeminine}}1 {±}{{$\pm$}}1 {≤}{{$\leq$}}1 {≥}{{$\geq$}}1 {×}{{$\times$}}1
}
\lstset{style=tfm}
\renewcommand{\lstlistingname}{Listing}
\renewcommand{\lstlistlistingname}{List of Listings}

\RequirePackage{csquotes}

% Captions: bold coloured label, small text. Tables have their caption above.
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\small\textcolor{tfmaccent}{\bfseries #1.}\ #2}%
  \ifdim\wd\@tempboxa>\dimexpr\hsize-1cm\relax
    {\leftskip0.5cm\rightskip0.5cm\small\setstretch{1.1}%
     \textcolor{tfmaccent}{\bfseries #1.}\ #2\par}%
  \else
    \global\@minipagefalse\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\AtBeginEnvironment{table}{\setlength{\abovecaptionskip}{0pt}%
  \setlength{\belowcaptionskip}{8pt}}
\renewcommand{\arraystretch}{1.2}

%% ---------------------------------------------------------------------------
%%  5. Guidance boxes and to-do notes (hidden with the `final' option)
%% ---------------------------------------------------------------------------
\newsavebox{\tfm@guidebox}
\iftfm@final
  % The content is typeset into a box that is thrown away
  \newenvironment{guidance}{\par\setbox\z@\vbox\bgroup}{\egroup}
  \newcommand{\todo}[2][]{}
\else
  \newenvironment{guidance}{%
    \par\medskip\noindent
    \begin{lrbox}{\tfm@guidebox}%
    \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule-4pt\relax}%
    \small\setstretch{1.1}\setlength{\parindent}{0pt}\setlength{\parskip}{0.4em}%
    \textcolor{tfmaccent}{\bfseries Template guidance}\par}{%
    \end{minipage}\end{lrbox}%
    {\color{tfmaccent}\vrule width 3pt}%
    {\fboxrule=0.4pt\fcolorbox{tfmaccent!50}{tfmaccent!5}{\usebox{\tfm@guidebox}}}%
    \par\medskip}
  % \todo{text} inline note; \todo[inline]{text} note in its own paragraph
  \newcommand{\todo}[2][]{%
    \ifstrequal{#1}{inline}
      {\par\noindent\colorbox{orange!20}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{%
        \small\textbf{To do:} #2}}\par}
      {\textcolor{orange!75!black}{\small[\textbf{To do:} #2]}}}
\fi

%% ---------------------------------------------------------------------------
%%  6. Thesis metadata (set in config.tex)
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
\newcommand{\Supervisor}[3][Supervisor]{%
  \stepcounter{tfm@supervisors}%
  \expandafter\gdef\csname tfm@sup@role@\arabic{tfm@supervisors}\endcsname{#1}%
  \expandafter\gdef\csname tfm@sup@name@\arabic{tfm@supervisors}\endcsname{#2}%
  \expandafter\gdef\csname tfm@sup@aff@\arabic{tfm@supervisors}\endcsname{#3}}
\newcounter{tfm@i}
\newcommand{\tfm@forsupervisors}[1]{% #1 may use \tfm@role, \tfm@name, \tfm@aff
  \setcounter{tfm@i}{0}%
  \loop\ifnum\value{tfm@i}<\value{tfm@supervisors}%
    \stepcounter{tfm@i}%
    \letcs{\tfm@role}{tfm@sup@role@\arabic{tfm@i}}%
    \letcs{\tfm@name}{tfm@sup@name@\arabic{tfm@i}}%
    \letcs{\tfm@aff}{tfm@sup@aff@\arabic{tfm@i}}%
    #1%
  \repeat}
% "A", "A and B", "A, B and C"
\newcommand{\tfm@supervisornames}{%
  \setcounter{tfm@i}{0}%
  \loop\ifnum\value{tfm@i}<\value{tfm@supervisors}%
    \stepcounter{tfm@i}%
    \ifnum\value{tfm@i}>1
      \ifnum\value{tfm@i}=\value{tfm@supervisors}\ and\ \else,\ \fi
    \fi
    \csname tfm@sup@name@\arabic{tfm@i}\endcsname
  \repeat}

% Public accessors to use in your own text
\newcommand{\thesistitle}{\tfm@title}
\newcommand{\thesisshorttitle}{\tfm@shorttitle}
\newcommand{\thesisauthor}{\tfm@author}
\newcommand{\thesisdegree}{\tfm@degree}
\newcommand{\thesisuniversity}{\tfm@university}
\newcommand{\thesisfaculty}{\tfm@faculty}
\newcommand{\thesistype}{\tfm@thesistype}
\newcommand{\thesisdate}{\tfm@date}
\newcommand{\thesissupervisors}{\tfm@supervisornames}

% Optional pages (switch them on/off in config.tex with \settoggle)
\newtoggle{tfmLicencePage}\toggletrue{tfmLicencePage}
\newtoggle{tfmApprovalPage}\togglefalse{tfmApprovalPage}
\newtoggle{tfmOriginalityPage}\toggletrue{tfmOriginalityPage}
% The user guide chapter is only included when compiling template-guide.tex
\newtoggle{tfmTemplateGuide}
\ifdefined\TemplateGuide\toggletrue{tfmTemplateGuide}\else\togglefalse{tfmTemplateGuide}\fi

%% ---------------------------------------------------------------------------
%%  7. Headings
%% ---------------------------------------------------------------------------
\iftfm@uppercase
  \newcommand{\tfm@chaptercase}[1]{\MakeUppercase{#1}}
\else
  \newcommand{\tfm@chaptercase}[1]{#1}
\fi
\def\@makechapterhead#1{%
  {\parindent\z@\raggedright\normalfont
   \ifnum\c@secnumdepth>\m@ne
     {\large\bfseries\color{tfmaccent}\MakeUppercase{\@chapapp}~\thechapter\par}%
     \nobreak\vskip 0.5em
   \fi
   {\Huge\bfseries\setstretch{1.0}\tfm@chaptercase{#1}\par}\nobreak
   \vskip 0.6em{\color{tfmaccent}\hrule height 1.2pt}\vskip 2.2em}}
\def\@makeschapterhead#1{%
  {\parindent\z@\raggedright\normalfont
   {\Huge\bfseries\setstretch{1.0}\tfm@chaptercase{#1}\par}\nobreak
   \vskip 0.6em{\color{tfmaccent}\hrule height 1.2pt}\vskip 2.2em}}
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-1.6em \@plus -0.4em \@minus -0.2em}{0.6em}{\normalfont\Large\bfseries\raggedright}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {-1.3em \@plus -0.3em \@minus -0.2em}{0.5em}{\normalfont\large\bfseries\raggedright}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {-1.1em \@plus -0.3em \@minus -0.2em}{0.4em}{\normalfont\normalsize\bfseries\raggedright}}
\def\@seccntformat#1{\textcolor{tfmaccent}{\csname the#1\endcsname}\hskip 0.8em}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand{\@pnumwidth}{2.4em}
\renewcommand{\@tocrmarg}{3.2em}

%% ---------------------------------------------------------------------------
%%  8. Headers and footers
%% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\ifnum\value{chapter}>0 \thechapter.\ \fi#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\newcommand{\tfm@headfont}{\footnotesize\color{tfmgray}}
\fancyhf{}
\iftfm@print
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
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \iftfm@print\fancyfoot[LE,RO]{\small\thepage}\else\fancyfoot[R]{\small\thepage}\fi}

%% ---------------------------------------------------------------------------
%%  9. Bibliography (natbib + BibTeX) and hyperlinks
%% ---------------------------------------------------------------------------
\ifdefstring{\tfm@bibstyle}{authoryear}
  {\RequirePackage[authoryear,round]{natbib}}
  {\RequirePackage[numbers,sort&compress]{natbib}}
\setlength{\bibsep}{0.3\baselineskip}

\RequirePackage{hyperref}
\iftfm@print
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
% Names used by \autoref ("Chapter 3", "Figure 2.1"...), capitalised
\newcommand{\tfm@autorefnames}{%
  \def\chapterautorefname{Chapter}\def\appendixautorefname{Appendix}%
  \def\sectionautorefname{Section}\def\subsectionautorefname{Section}%
  \def\subsubsectionautorefname{Section}\def\figureautorefname{Figure}%
  \def\tableautorefname{Table}\def\equationautorefname{Equation}%
  \def\lstlistingautorefname{Listing}\def\algocfautorefname{Algorithm}%
  \def\pageautorefname{page}\def\footnoteautorefname{Footnote}}
\expandafter\addto\csname extras\tfm@english\endcsname{\tfm@autorefnames}
\AtBeginDocument{\tfm@autorefnames}

%% ---------------------------------------------------------------------------
%% 10. Document structure helpers
%% ---------------------------------------------------------------------------
\newcommand{\frontmatter}{\cleardoublepage\pagenumbering{roman}}
\newcommand{\mainmatter}{\cleardoublepage\pagenumbering{arabic}}

% Unnumbered chapter listed in the table of contents and in the headers
\newcommand{\frontchapter}[1]{%
  \chapter*{#1}%
  \phantomsection\addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}}

% Table of contents and lists, also listed in the table of contents
\newcommand{\tfm@listin}[2]{\cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{#1}%
  \begingroup\setstretch{1.15}\hypersetup{linkcolor=black}#2\endgroup}
\newcommand{\tableofcontentsintoc}{\cleardoublepage
  \pdfbookmark[0]{\contentsname}{toc}%
  \begingroup\setstretch{1.15}\hypersetup{linkcolor=black}\tableofcontents\endgroup}
\newcommand{\listoffiguresintoc}{\tfm@listin{\listfigurename}{\listoffigures}}
\newcommand{\listoftablesintoc}{\tfm@listin{\listtablename}{\listoftables}}
\newcommand{\listofalgorithmsintoc}{\tfm@listin{List of Algorithms}{\listofalgorithms}}
\newcommand{\listoflistingsintoc}{\tfm@listin{\lstlistlistingname}{\lstlistoflistings}}
\renewcommand{\listalgorithmcfname}{List of Algorithms}

% \bibliographyintoc{references}: the References chapter, from references.bib
\newcommand{\bibliographyintoc}[1]{%
  \cleardoublepage\phantomsection
  \addcontentsline{toc}{chapter}{References}%
  \renewcommand{\bibname}{References}%
  \ifdefstring{\tfm@bibstyle}{authoryear}
    {\bibliographystyle{plainnat}}{\bibliographystyle{unsrtnat}}%
  \begingroup\small\setstretch{1.1}\bibliography{#1}\endgroup}

%% ---------------------------------------------------------------------------
%% 11. Cover page
%% ---------------------------------------------------------------------------
% Draws the logo if the file exists; otherwise a neutral placeholder box
\newcommand{\tfm@drawlogo}[2]{% #1 macro holding the file name, #2 height
  \ifdefempty{#1}{}{%
    \IfFileExists{#1}
      {\includegraphics[height=#2,keepaspectratio]{#1}}
      {{\color{tfmaccent!50}\fboxsep=0pt\fbox{\parbox[c][#2][c]{1.6\dimexpr#2\relax}%
        {\centering\scriptsize\color{tfmaccent}University\\logo}}}}}}

\newcommand{\tfm@coverline}[2]{% label, value
  {\color{tfmgray}\small\MakeUppercase{#1}}\\[0.15em]{\large #2}\par\medskip}

\newcommand{\makecover}{%
  \begingroup
  % Official cover provided by the university as a PDF, as in the original
  % template: it fills the first page and the generated cover follows it
  \ifdefempty{\tfm@officialcover}{}{%
    \thispagestyle{empty}\ThisULCornerWallPaper{1}{\tfm@officialcover}~\clearpage}%
  \thispagestyle{empty}%
  \setstretch{1.15}%
  \noindent
  % Coloured band along the left edge of the page
  \begin{textblock*}{1.2cm}(0cm,0cm)%
    \noindent\hbox{\textcolor{tfmaccent}{\rule{0.9cm}{\paperheight}}%
      \textcolor{tfmaccent!35}{\rule{0.15cm}{\paperheight}}}%
  \end{textblock*}%
  \begin{minipage}[t][\dimexpr\textheight-1.5\baselineskip\relax][t]{\textwidth}
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
    {\fontsize{24}{30}\selectfont\bfseries\raggedright\tfm@title\par}
    \ifdefempty{\tfm@subtitle}{}{\vspace{0.6em}{\Large\raggedright\tfm@subtitle\par}}
    \ifdefempty{\tfm@titlesl}{}{\vspace{0.9em}%
      {\large\itshape\color{tfmgray}\raggedright
       \ifdefempty{\tfm@babelsecond}{\tfm@titlesl}%
         {\foreignlanguage{\tfm@babelsecond}{\tfm@titlesl}}\par}}
    \vfill
    \begin{minipage}[t]{0.6\textwidth}
      \raggedright
      \ifdefempty{\tfm@author}{}{\tfm@coverline{Author}{\tfm@author}}%
      \tfm@forsupervisors{\tfm@coverline{\tfm@role}{\tfm@name}%
        \vspace{-0.6em}{\small\color{tfmgray}\tfm@aff\par}\medskip}%
    \end{minipage}\hfill
    \begin{minipage}[t]{0.36\textwidth}
      \raggedleft
      \ifdefempty{\tfm@department}{}{\tfm@coverline{Department}{\tfm@department}}
      \ifdefempty{\tfm@academicyear}{}{\tfm@coverline{Academic year}{\tfm@academicyear}}
      \ifdefempty{\tfm@session}{}{\tfm@coverline{Session}{\tfm@session}}
    \end{minipage}\par
    \vspace{1cm}
    {\color{tfmaccent}\rule{\textwidth}{0.6pt}\par}
    \vspace{0.3em}
    {\small\color{tfmgray}\ifdefempty{\tfm@city}{}{\tfm@city,\ }\tfm@date\par}
  \end{minipage}%
  \endgroup
  \clearpage}

%% ---------------------------------------------------------------------------
%% 12. Licence / copyright page
%% ---------------------------------------------------------------------------
\newcommand{\tfm@cc}[3]{% code, name, url
  \csdef{tfm@lic@#1}{This work is licensed under a Creative Commons #2 4.0
    International licence (CC~\MakeUppercase{#1}~4.0). \url{#3}}}
\tfm@cc{by}{Attribution}{https://creativecommons.org/licenses/by/4.0/}
\tfm@cc{by-sa}{Attribution-ShareAlike}{https://creativecommons.org/licenses/by-sa/4.0/}
\tfm@cc{by-nc}{Attribution-NonCommercial}{https://creativecommons.org/licenses/by-nc/4.0/}
\tfm@cc{by-nc-sa}{Attribution-NonCommercial-ShareAlike}{https://creativecommons.org/licenses/by-nc-sa/4.0/}
\tfm@cc{by-nd}{Attribution-NoDerivatives}{https://creativecommons.org/licenses/by-nd/4.0/}
\tfm@cc{by-nc-nd}{Attribution-NonCommercial-NoDerivatives}{https://creativecommons.org/licenses/by-nc-nd/4.0/}
\csdef{tfm@lic@all-rights-reserved}{\textcopyright\ \the\year\ \tfm@author. All rights
  reserved. No part of this work may be reproduced without the prior written permission
  of the author, except as permitted by the applicable intellectual property law.}

\newcommand{\makelicencepage}{%
  \iftoggle{tfmLicencePage}{%
    \clearpage\thispagestyle{empty}%
    \vspace*{\fill}
    \begingroup\small\setstretch{1.2}\setlength{\parindent}{0pt}\setlength{\parskip}{0.6em}%
    \textbf{\tfm@title}\ifdefempty{\tfm@subtitle}{}{: \tfm@subtitle}\par
    \tfm@thesistype\ifdefempty{\tfm@degree}{}{, \tfm@degree}\ifdefempty{\tfm@university}{}{,
      \tfm@university}\ifdefempty{\tfm@academicyear}{}{, \tfm@academicyear}.\par
    \tfm@author\ifdefempty{\tfm@authoremail}{}{\ -- \href{mailto:\tfm@authoremail}{\nolinkurl{\tfm@authoremail}}}\par
    \bigskip
    \ifcsdef{tfm@lic@\tfm@licence}{\csuse{tfm@lic@\tfm@licence}}{\tfm@licence}\par
    \endgroup
    \clearpage}{}}

%% ---------------------------------------------------------------------------
%% 13. Declarations and signatures
%% ---------------------------------------------------------------------------
\newcommand{\tfm@signature}[2]{% name, role
  \begin{minipage}[t]{0.45\textwidth}\centering
    \vspace*{2.2cm}
    \rule{0.85\linewidth}{0.4pt}\par
    {\small #1\par\color{tfmgray}#2}
  \end{minipage}}
\newcommand{\tfm@placedate}{\ifdefempty{\tfm@city}{}{\tfm@city,\ }\tfm@date}

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
%% 14. Abstracts
%% ---------------------------------------------------------------------------
\newenvironment{abstractpage}{%
  \frontchapter{Abstract}}{%
  \ifdefempty{\tfm@keywords}{}{\par\bigskip\noindent\textbf{Keywords:} \tfm@keywords}%
  \cleardoublepage}
\newenvironment{abstractsecondlanguage}{%
  \frontchapter{\tfm@abstractsl}%
  \ifdefempty{\tfm@titlesl}{}{\noindent\textit{\tfm@titlesl}\par\medskip}%
  \ifdefempty{\tfm@babelsecond}{\begin{otherlanguage}{\tfm@english}}%
    {\begin{otherlanguage}{\tfm@babelsecond}}}{%
  \ifdefempty{\tfm@keywordssl}{}{\par\bigskip\noindent\textbf{\tfm@keywordslabelsl:}
    \tfm@keywordssl}%
  \end{otherlanguage}\cleardoublepage}

%% ---------------------------------------------------------------------------
%% 15. Sustainable Development Goals (SDG) table helper
%% ---------------------------------------------------------------------------
% \sdg{number}{name}{level}  with level = H (high), M (medium), L (low), N (not applicable)
\newcommand{\tfm@sdgmark}[2]{\ifstrequal{#1}{#2}{\textcolor{tfmaccent}{$\bullet$}}{}}
\newcommand{\sdg}[3]{\textbf{SDG #1.} #2 & \tfm@sdgmark{#3}{H} & \tfm@sdgmark{#3}{M}
  & \tfm@sdgmark{#3}{L} & \tfm@sdgmark{#3}{N}\\}

%% ---------------------------------------------------------------------------
%% 16. Sanity checks
%% ---------------------------------------------------------------------------
\AtBeginDocument{%
  \ifdefempty{\tfm@title}{\ClassWarningNoLine{tfmthesis}{No \string\ThesisTitle\space set in config.tex}}{}%
  \ifdefempty{\tfm@author}{\ClassWarningNoLine{tfmthesis}{No \string\ThesisAuthor\space set in config.tex}}{}%
  \ifnum\value{tfm@supervisors}=0
    \ClassWarningNoLine{tfmthesis}{No \string\Supervisor\space set in config.tex}\fi
}
\endinput
