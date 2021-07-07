%% violacoda-doc.cls
%
% A LaTeX class for game documents and personal technical projects.
%
%
% Copyright 2021 Piotr Szymczak (violacoda)
%
% This work consists of the following files:
%    violacoda-doc.cls
%    doc/violacoda-doc.tex
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
% http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `author-maintained'. 
% 
% The Author and Maintainer of this work is Piotr Szymczak (violacoda)
%
%
% TODO: This class is early in development
% English & Polish versions
% Advanced font options
% etc.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{violacoda-doc}[07/07/2021 Violacoda document class]

% Process class options

\newcounter{papersizeoption}
\newcounter{fontoption}

\newif\ifmodule@letterpaper
\newif\ifmodule@seriffont
\newif\ifmodule@tightsqueeze

\DeclareOption{letterpaper}{\module@letterpapertrue\stepcounter{papersizeoption}}
\DeclareOption{a4paper}{\module@letterpaperfalse\stepcounter{papersizeoption}}

\DeclareOption{tightsqueeze}{\module@tightsqueezetrue}

\DeclareOption{serif}{\module@seriffonttrue\stepcounter{fontoption}}
\DeclareOption{sansserif}{\module@serifontfalse\stepcounter{fontoption}}

\DeclareOption*{
    \ClassError{violacoda-doc}{Unrecognised option '\CurrentOption'}{Valid options are:\MessageBreak
        a4paper,letterpaper,tightsqueeze,\MessageBreak serif,sansserif}
}

\ExecuteOptions{a4paper}         % Default paper size is A4

\ExecuteOptions{sans-serif}      % Default font option is serif

\ProcessOptions\relax

\ifcase\thepapersizeoption\or\or\else
    \ClassError{violacoda-doc}{a4paper and letterpaper options are mutually exclusive}
        {The input file contains a statement like:\MessageBreak
         \protect\documentclass[letterpaper,a4paper]{violacoda-doc}\MessageBreak
         You can only select one paper size, either letterpaper or a4paper.\MessageBreak
         The default is a4paper.}
\fi

\ifcase\thefontoption\or\or\else
    \ClassError{violacoda-doc}{serif and sansserif options are mutually exclusive}
        {The input file contains a statement like:\MessageBreak
        \protect\documentclass[serif,sansserif]{violacoda-doc}.\MessageBreak
        You can only select one font style, either serif or sansserif.\MessageBreak
        The default is sansserif.}
\fi

% Process paper size options

\setlength\voffset{-1in}
\setlength\hoffset{-1in}

\ifmodule@letterpaper
    \PassOptionsToClass{letterpaper}{article}
    \addtolength\voffset{-17.6mm}
    \addtolength\hoffset{2.95mm}
\else
    \PassOptionsToClass{a4paper}{article}
    \PassOptionsToClass{twoside}{article}
\fi

% Load the standard LaTeX 'article' document class that module is based on

\LoadClass[twocolumn]{article}

% Set page margins

\setlength{\oddsidemargin}{0.8cm}
\setlength{\evensidemargin}{0.8cm}

\setlength{\topmargin}{2.6cm}

\setlength{\textheight}{25.4cm}
\setlength{\textwidth}{19.4cm}

\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{0cm}

\setlength{\footskip}{0.7cm}

\setlength{\columnsep}{1.15cm}

\pagenumbering{arabic}

\ifmodule@letterpaper
    \setlength{\headheight}{0cm}
    \setlength{\headsep}{0cm}
\else
    \addtolength{\topmargin}{-\headheight}
    \addtolength{\topmargin}{-\headsep}
    \RequirePackage{fancyhdr}                   % Add headers and footers
    \fancypagestyle{plain}{
        \fancyhf{}                              % Clear all header and footer fields
        \fancyhead[LO,RE]{\slshape \leftmark}
        \fancyhead[RO,LE]{\slshape \rightmark}
        \fancyfoot[C]{\thepage}                 % Except the center
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
    }
    \pagestyle{plain}
\fi

% Float placement options

\renewcommand{\topfraction}{0.9}                % Max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}             % Max fraction of floats at bottom

% Parameters for TEXT pages (not float pages)

\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{2}                    % For 2-column pages
\renewcommand{\dbltopfraction}{0.9}             % Fit big float above 2-column
\renewcommand{\textfraction}{0.07}              % Allow minimal text

% Parameters for FLOAT pages (not text pages)
% Note: \floatpagefraction must be less than \topfraction above

\renewcommand{\floatpagefraction}{0.7}          % Require fuller float pages
\renewcommand{\dblfloatpagefraction}{0.7}       % Require fuller float pages

% Process font options

\RequirePackage[T1]{fontenc}                    % Use T1 (8-bit) font encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}                        % Use Latin Modern instead of Computer Modern for symbols etc.
\RequirePackage{xfrac}                          % Get a good-looking 1/2 symbol

\newcommand\half{\sfrac{1}{2}}                  % Get a good-looking 1/2 symbol

\ifmodule@seriffont
    \IfFileExists{souvenir.sty}{                % If ITC Souvenir font is installed in this LaTeX distribution
        \RequirePackage{souvenir}               % Use ITC Souvenir as serifed font
        \renewcommand{\bldefault}{d}            % Use demi-bold instead of bold
        % Get a good-looking copyright (C) symbol
        \renewcommand*\copyright{{\usefont{T1}{lmr}{m}{n}\textcopyright}}
        % Registered trademark (R) symbol
        \newcommand*\registered{{\usefont{T1}{lmr}{m}{n}\textregistered}}
        \renewcommand\half{{\usefont{T1}{lmr}{m}{n}\sfrac{1}{2}}}
    }{
        \ClassWarning{violacoda-doc}{%
            ITC Souvenir not detected, substituting Bookman as default serifed font.}
        \RequirePackage{bookman}                % Use Bookman as serifed font
    }
    \renewcommand*\familydefault{\rmdefault}    % Default to serifed font
\else
    \RequirePackage{avant}                      % Use URW Gothic as default sans-serif font
    \renewcommand*\familydefault{\sfdefault}    % Default to sans-serif font
\fi

\renewcommand{\tiny}        {\fontsize {4pt} {4.8pt}\selectfont}
\renewcommand{\scriptsize}  {\fontsize {5pt} {6.0pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize {7pt} {8.4pt}\selectfont}
\renewcommand{\small}       {\fontsize {8pt} {9.6pt}\selectfont}
\renewcommand{\normalsize}  {\fontsize {9pt}{10.8pt}\selectfont}
\renewcommand{\large}       {\fontsize{10pt}{12.0pt}\selectfont}
\renewcommand{\Large}       {\fontsize{11pt}{13.2pt}\selectfont}
\renewcommand{\LARGE}       {\fontsize{13pt}{15.6pt}\selectfont}
\renewcommand{\huge}        {\fontsize{16pt}{19.2pt}\selectfont}
\renewcommand{\Huge}        {\fontsize{17.28pt}{20.74pt}\selectfont}

% Load the rest of the required packages

\RequirePackage[pass,paperwidth=\paperwidth,paperheight=\paperheight]{geometry} % Page size
\RequirePackage[explicit,newparttoc]{titlesec}  % Redefine section headings
\RequirePackage[polish]{babel}                  % Polish translations
\RequirePackage{titletoc}                       % Redefine table of contents
\RequirePackage{array}                          % Format table headings
\RequirePackage{booktabs}                       % Underline table headings
\RequirePackage{caption}                        % Allow non-numbered figure and table captions
\RequirePackage{framed}                         % Boxed text
\RequirePackage{xstring}                        % Manipulate strings
\RequirePackage{graphicx}                       % Allow images and text across two columns

\graphicspath{ {images/} }

% Hyperlinks

\RequirePackage[linktocpage]{hyperref}          % Allow hyperlinks, only page numbers in TOC are clickable
\RequirePackage[dvipsnames]{xcolor}             % Pre-defined color names
\hypersetup{colorlinks=true,
    urlcolor=MidnightBlue,                      % Color for external links
    linkcolor=MidnightBlue,                     % Color for internal links (including ToC)
    citecolor=MidnightBlue}                     % Color for references

% Key-value pairs

\RequirePackage{pgfkeys}
\input{pgfutil-common}
\input{pgfmath.code}

% Define a narrow breaking space

\newcommand*{\thinspacebrk}{\hskip0.16667em\relax}

% Tightsqueeze option for reduced spacing

\ifmodule@tightsqueeze
    \titlespacing*{\part}{0pt}{0pt}{0pt}
    \titlespacing*{\section}{0pt}{0.5ex plus .2ex}{0.5ex plus .2ex}
    \titlespacing*{\subsection}{0pt}{0.5ex plus .2ex}{0.5ex plus .2ex}
    \FrameSep5pt
    \renewcommand{\arraystretch}{1}
\else
    \renewcommand{\arraystretch}{1.2}           % Default: increase the table row spacing a little
\fi

% Footnote options

% Use footnote symbols instead of numbers
\renewcommand*{\thefootnote}{\fnsymbol{footnote}}           
% Footnote indentation
\renewcommand\@makefntext[1]{\leftskip=0.5em\hskip-0.5em\makebox[0.5em]{\@makefnmark}#1}

% Title Page

\renewcommand\maketitle{\hypersetup{pageanchor=false}   % No internal links to title page allowed
\begin{titlepage}
\vspace*{\fill}
\begin{center}
\Huge \textbf{\@title} \par
\@author
\@subtitle
\@coverimg
\end{center}
\@abstract
\@copyright
\@contact
\vfill
\@quote
\normalsize utworzono \@date \par
\end{titlepage}
\hypersetup{pageanchor=true}
\global\let\maketitle\relax
\global\let\@author\@empty
\global\let\@subtitle\@empty
\global\let\@coverimg\@empty
\global\let\@abstract\@empty
\global\let\@copyright\@empty
\global\let\@contact\@mempty
\global\let\@quote\@empty
\global\let\title\relax
\global\let\author\relax
\global\let\date\today
}

\newcommand\showtitle[1][\@title]{\begin{center}
\LARGE\textbf{#1}
\end{center}
\let\if@afterindentfalse}

\renewcommand\@author{\relax}
\renewcommand{\author}[1]{\gdef\@author{\vskip 0.5em\Large \textbf{#1}}}

\newcommand\@subtitle{\relax}
\newcommand\@coverimg{\relax}
\newcommand\@abstract{\relax}
\newcommand\@copyright{\relax}
\newcommand\@contact{\relax}
\newcommand\@quote{\relax}

\newcommand{\subtitle}[1]{\gdef\@subtitle{\vskip 0.5em \LARGE \textbf{\MakeUppercase{#1}}}}
\newcommand{\coverimage}[1]{\gdef\@coverimg{\vskip 0.5em \includegraphics[width=\textwidth]{#1} \par}}
\renewcommand{\abstract}[1]{\gdef\@abstract{\vskip 0.5em #1 \par}}

\newcommand{\copyrightblock}[1]{\gdef\@copyright{\vskip 0.5em
\begin{quote}
\centering
#1
\end{quote}}}

\newcommand{\contactblock}[4][p{5.9cm} p{5.9cm} p{5.9cm}]{\gdef\@contact{\vskip 0.5em
\begin{tabular}{#1}
{#2} & {#3} & {#4}
\end{tabular}}}

\newcommand{\titlequote}[1]{\gdef\@quote{
\begin{center}
\vskip 0.5em \Large \emph{``#1''} 
\end{center} \par}}

% Table of Contents

\renewcommand\tableofcontents{%
    \noindent\Large\textbf{\MakeUppercase\contentsname}\vspace{1em}\@starttoc{toc}
}

\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
\titlecontents{part}[0em]{\normalsize\bfseries}{CZĘŚĆ \thecontentslabel :\MakeUppercase}{}{\quad\thecontentspage}[\vspace{1.5ex plus .2ex}]
\titlecontents*{section}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]
\titlecontents*{subsection}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]
\titlecontents*{subsubsection}[0em]{\normalsize}{}{}{~\thecontentspage}[\unskip, ][.\vspace{1.5ex plus .2ex}]

% Running heads (used on A4 paper size only)

\newcommand\titlerunning[1]{%
    \gdef\runningtitle{#1}
}
\ifmodule@letterpaper\else
    \renewcommand{\partmark}[1]{\markright{#1}{}}
    \renewcommand{\sectionmark}[1]{}
    \renewcommand{\subsectionmark}[1]{}
    \renewcommand{\leftmark}{\runningtitle}
    \titlerunning{\@title}
\fi

% Headings

\renewcommand\thepart{\arabic{part}}
\renewcommand\thesection{}
\renewcommand\thesubsection{\arabic{subsection}}
\renewcommand\thesubsubsection{\arabic{subsection}\alph{subsubsection}}

\titleformat{\part}[block]
{\LARGE\bfseries\filcenter}
{\LARGE CZĘŚĆ \thepart:}{0.5em}{\MakeUppercase{#1}}

\titleformat{\section}[hang]
{\Large\bfseries\filcenter}
{}{0em}{\MakeUppercase{#1}}

\titleformat{name=\section,numberless}[block]                   % How to handle \section*
{\Large\bfseries\filcenter}
{}{0em}{#1\phantomsection\addcontentsline{toc}{section}{#1}}

\titleformat{\subsection}[hang]         
{\normalfont\bfseries\filright}
{\thesubsection.}{0.5em}{\MakeUppercase{#1}}

\titleformat{\subsubsection}[hang]
{\normalfont\bfseries\filright}
{\thesubsubsection.}{0.5em}{\MakeUppercase{#1}}

% Default section spacing, for references
%
%\titlespacing*{\part} {0pt}{50pt}{40pt}
%\titlespacing*{\section} {0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}
%\titlespacing*{\subsection} {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%\titlespacing*{\subsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
%\titlespacing*{\paragraph} {0pt}{3.25ex plus 1ex minus .2ex}{1em}
%\titlespacing*{\subparagraph} {\parindent}{3.25ex plus 1ex minus .2ex}{1em}

% Boxed text 

\newenvironment{boxtext}{%
\if@nobreak
    \vspace{-\topsep}
\fi
\begin{framed}\@afterheading}{\end{framed}\aftergroup\@afterindentfalse\aftergroup\@afterheading}

% Single-column text

\newcommand\onecolumninline[1]{%
\newlength{\tmpparindent}
\newlength{\tmpparskip}
\setlength{\tmpparindent}{\parindent}
\setlength{\tmpparskip}{\parskip}
\twocolumn[{
    \setlength{\parindent}{\tmpparindent}
    \setlength{\parskip}{\tmpparskip}
    \fussy
    #1
    \vspace{2ex}
}]
}

% Tables

%\newcolumntype{b}{>{\bfseries}c}        % New column type 'b' for bold, centred headings
%\newcounter{numcols@module}             % Counter to keep track of how many columns are in the table

% Underline table headers

%\newtoks\module@tableul
%\newcommand{\tableul}[1]{%
%    \noalign{%
%        \global\module@tableul={}%
%        \toks@={\cmidrule(1{\tabcolsep}r{\tabcolsep})}%
%        \count@=\z@
%        \loop\ifnum\count@<#1\relax
%            \advance\count@\@ne
%            \edef\module@temp{\the\toks@{\the\count@-\the\count@}}%
%            \global\module@tableul\expandafter{\the\expandafter\module@tableul\module@temp}%
%        \repeat
%    }%
%    \the\module@tableul
%}

% Typeset the table heading
% Takes a column type as an optional argument (defaults to 'c' for centred text)

%\newcommand\tableheader[2][c]{{%
%    \edef\lbracetoken{\string{}
%    \edef\rbracetoken{\string}}
%    \StrCount{#2}{&}[\numamps]\global\setcounter{numcols@module}{\numamps}\stepcounter{numcols@module}
%    \newcommand\source{\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken#2\rbracetoken}
%    \newcommand\replace{\rbracetoken&\string\multicolumn\lbracetoken 1\rbracetoken\lbracetoken#1\rbracetoken\lbracetoken#2\rbracetoken}
%    \StrSubstitute{\source}{ & }{\replace}[\tmptblhdr]
%    \StrExpand{\tmptblhdr}{\tmptblhdrexpand}
%    \tokenize{\tmptbltok}{\tmptblhdr}
%    \global\let\tableheader@module\tmptbltok
%}\\[-2ex] % hack to get around the fact that it's not allowed to have non-expandable text in the same cell as \multicolumn
%\tableheader@module\\
%\tableul{\thenumcols@module}
%}

