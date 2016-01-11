% 
% apa_HRI.cls version 2.0   -- MAG 10/5/10 changed from version 1.0 to 2.0.
% 
% Version 2.0 has the following changes from version 1.0
%	Author and level one headings changed from all caps to standard capitalization 
%	Font size changed from 11 point to 10 point.
% 
% This class is an extension to the apa.cls developed by Athanassios Protopapas (see information below).
% This class directly replicates apa.cls version 1.3.4, but adds information needed to
% format a document in the HRI Journal format.  All capability of apa.cls version 1.3.4
% is retained, but note that the apa.cls capability is not maintained by the original authors.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% Use with LaTeX2e, \documentclass[man|jou|doc|HRI]{apa}
% Default mode is doc.

% ********************************************************************************
% Information about apa.cls from which this class is derived.
% ********************************************************************************  
%
% apa.cls  version 1.3.4
%
% NOTE CHANGE IN VERSION NUMBERING : 1.21--1.28 should have been 1.2.1--1.2.8
%
% Athanassios Protopapas, December 2008
% protopap@ilsp.gr
%
% This package may be distributed under the terms of the LaTeX Project Public
% License, as described in lppl.txt in the base LaTeX distribution.  Either
% version 1.0 or, at your option, any later version.
%
% The term "package", in the above license statement, applies to all files
% included with apa.cls (language files, examples, configuration,
% instructions etc.) -- they may be all distributed under LPPL.
%
% Use with LaTeX2e, \documentclass[man|jou|doc]{apa}
% Default mode is doc. Conforms to the APA manual 5th ed.
%
% ** Read apacls.txt and examples.txt carefully before using **
%
%%%%%%%%%%%%%%%%%
% ********************************************************************************
% End of information about apa.cls from which this class is derived.
% ********************************************************************************  


\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{apa_HRI}[2008/12/09 American Psychological Association format v1.3.4]

\DeclareOption{man}{%
\def\def@man{\@manmode}
}

\DeclareOption{jou}{%
\def\def@jou{\@joumode}
}

\DeclareOption{HRI}{%          	% MAG August, 2010
\def\def@HRI{\@HRImode}	
}

\DeclareOption{NoSectionNumbering}{%		MAG August 2010
\def\def@NoSectionNumbering{\@NoSectionMode}
}				

\DeclareOption{doc}{%
\def\def@doc{\@docmode}
}

\DeclareOption{babel}{%
\def\def@babel{\@babel}
}

\DeclareOption{notimes}{%
\@ifundefined{def@jou}{}{\def\def@notimes{\@notimes}}
}

\DeclareOption{notxfonts}{% -- thp 2005/07/23
\@ifundefined{def@jou}{}{\def\def@notxfonts{\@notxfonts}}
}

\DeclareOption{nosf}{%
\@ifundefined{def@man}{}{\def\def@nosf{\@nosf}}
}

\DeclareOption{fignum}{%
\@ifundefined{def@man}{}{\def\fig@num{\relax}}
}

\DeclareOption{floatmark}{%
\@ifundefined{def@man}{}{\def\float@mark{\relax}}
}

\DeclareOption{longtable}{%
\def\long@table{\relax}
}

\DeclareOption{tt}{%
\@ifundefined{def@man}{}{\def\tt@family{\relax}}
}

\DeclareOption{helv}{%
\@ifundefined{def@man}{}{\def\helv@family{\relax}}
}

\DeclareOption{notab}{\def\no@tab{\relax}}

\DeclareOption{nobf}{\def\no@bf@title{\relax}}

\DeclareOption{noapacite}{%         -- Philip Kime 2008/12/03
\def\def@noapacite{\@noapacitemode}
}

\DeclareOption*{%
\PassOptionsToClass{\CurrentOption}{article}%
}

\ProcessOptions

\@ifundefined{def@noapacite}%       -- Philip Kime 2008/12/03
  {\ClassWarningNoLine{apa}{Using BibTeX with apacite for citations and references}}%
  {\ClassWarningNoLine{apa}{apacite not loaded -- User may load BibLaTeX}}

\@ifundefined{def@man}{%
 \@ifundefined{def@jou}{%
  \@ifundefined{def@HRI}{%  		% MAG August 2010
   \@ifundefined{def@doc}{%
    \def\def@doc{\@docmode}
    \ClassWarningNoLine{apa}{Using default mode (doc)}
   }{}
  }{}  % MAG August 2010
 }{}
}{}

%=================================================================

\@ifundefined{def@man}{}{%
\LoadClass[11pt]{article}
%
% endnotes and endfloat loaded later
% longtable must be loaded before endfloat
%
\@ifundefined{long@table}{}{%
 \RequirePackage{longtable}
%
% longtable messes with captions too, we need to intervene to match style
%
\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox{\linewidth}{%
      \vskip 10pt%
      #1{#2}%
      \let\BBAB\table@BBAB%   -- thp 2005/07/23
      \par\emph{#3}%
      \let\BBAB\normal@BBAB%  -- thp 2005/07/23
    \endgraf\vskip\baselineskip}%
  \hss}}}
}% END of loading longtable
%
% Switch font family for manuscript if required
%
\@ifundefined{tt@family}{}{%
% A typewriter font can be used as in the APA manual example. Since tt has
% no bold (or bold-italic), the cmss font metrics are loaded instead
% \DeclareFontShape{OT1}{cmtt}{bx}{n}{ <-> sub * cmss/bx/n }{} % this fails
 \DeclareFontShape{OT1}{cmtt}{bx}{n}{ <-> cmssbx10 }{}  % probably not the
 \DeclareFontShape{OT1}{cmtt}{bx}{it}{ <-> cmssbxo10}{} % right way to do it
 \renewcommand{\familydefault}{cmtt}
 }
\@ifundefined{helv@family}{}{%
 \renewcommand{\familydefault}{phv}}
}

%
% For jou mode, load times (and related math fonts) if available
% First try txfonts because they are supposed to have better math definitions
%
\@ifundefined{def@jou}{}{%
 \LoadClass[twoside]{article}
 \@ifundefined{def@notimes}{%
  \newif\iftxfonts          % -- thp 2005/07/23 
  \txfontsfalse             % added checks for txfonts because they may be undesirable
                            % for example, there are no Greek txfonts but there are times
  \IfFileExists{txfonts.sty}{\@ifundefined{def@notxfonts}{\txfontstrue}{}}{}
   \iftxfonts%
    \RequirePackage{txfonts}%
    \typeout{apa.cls: Using txfonts}% Changed from Warning -- thp 2005/12/28
    %%%
    % According to Erik Meijer, txfonts causes problems if amsmath is loaded later
    % (i.e., via \usepackage by the user); instead of providing yet another option
    % to load amsmath by apa.cls, we adopt Erik's suggestion to undefine temporarily
    % the offending macros -- thp 2005/12/28
    \let\tempiint\iint\let\iint\undefined
    \let\tempiiint\iiint\let\iiint\undefined
    \let\tempiiiint\iiiint\let\iiiint\undefined
    \let\tempidotsint\idotsint\let\idotsint\undefined
    \let\tempopenbox\openbox\let\openbox\undefined
    \AtBeginDocument{%
     \let\iint\tempiint\let\tempiint\undefined
     \let\iiint\tempiiint\let\tempiiint\undefined
     \let\iiiint\tempiiiint\let\tempiiiint\undefined
     \let\idotsint\tempidotsint\let\tempidotsint\undefined
     \let\openbox\tempopenbox\let\tempopenbox\undefined
    }
    %%% end of taking care of txfonts problems
   \else%
    % if txfonts are not available/desirable, try pslatextimes/mathptm
    \IfFileExists{pslatex.sty}
     {\RequirePackage{pslatex}}
     % if pslatex is not available, try times/mathptm
     {\RequirePackage{times}
      \IfFileExists{mathptm.sty}{\RequirePackage{mathptm}}{}}%
   \fi% txfonts not available/desirable
 }{}% def@notimes
}% def@jou

\@ifundefined{def@HRI}{}{%			% MAG August 2010
\LoadClass[10pt]{article}				% MAG October 2010 -- 11pt to 10pt -- makes no difference
}

\@ifundefined{def@doc}{}{%
\LoadClass[11pt]{article}
}

%========= Language portability parameters ===========

% Language-specific definition of strings is handled externally -- thp 2005/12/30
% Based on handling of the same issue in apacite.sty

% First define the default English macros in case no external file is present or needed
\def\rheadname{Running head:}
\def\acksname{Author Note}
\def\figurecaptionsname{Figure Captions}
\def\notesname{Footnotes}

\AtBeginDocument{% so that we know what language is active in babel

% \typeout{\string\languagename\space is\space\languagename}
% \@ifundefined{iflanguage}% this is defined by babel, so it means babel is loaded
                           % Unfortunately, because babel is built into the format
                           % in modern distributions, \iflanguage is defined and 
                           % \languagename contains whichever language happens to be
                           % last in the definition list, whether or not the babel 
                           % package is loaded by the current document 

 \@ifundefined{def@babel}% this is defined only if the user requested loading babel
  {\def\@apa@langfile{english.apa}}
  {\def\@apa@langfile{\languagename.apa}}
 \InputIfFileExists{\@apa@langfile}{}{%
  \ClassWarningNoLine{apa}{Language definition file \@apa@langfile\space not found}
 }%
}

%========== Load babel if required ===================

\@ifundefined{def@babel}{}{% -- thp 2005/07/23
 \RequirePackage{babel}    % -- thp 2005/07/23, removed options 2005/12/28
} 

%========== Load new apacite =========================

\@ifundefined{def@noapacite}%       -- Philip Kime 2008/12/03
  {\@ifundefined{def@man}{%         -- thp 2005/07/23
   \RequirePackage{apacite}[2005/06/08]}
   {\RequirePackage[bibnewpage]{apacite}[2005/06/08]}}{}

%========== APA Section heading & seriation, from theapa.sty

%
% \apa@startsection{Heading Indent}{Beforeskip}{Afterskip}{Heading}
%
\def\apa@startsection#1#2#3{\@startsection{}{}{#1}{#2}{#3}{\relax}*}

\newskip\b@level@one@skip   \b@level@one@skip=2.5ex plus 1ex minus .2ex
\newskip\e@level@one@skip   \e@level@one@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@two@skip   \b@level@two@skip=2.5ex plus 1ex minus .2ex
\newskip\e@level@two@skip   \e@level@two@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@three@skip \b@level@three@skip=2.0ex plus .8ex minus .2ex
\newskip\e@level@three@skip \e@level@three@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@four@skip  \b@level@four@skip=1.8ex plus .8ex minus .2ex
\newskip\e@level@four@skip  \e@level@four@skip=1.5ex plus .6ex minus .1ex
\newskip\b@level@five@skip  \b@level@five@skip=1.8ex plus .8ex minus .2ex
\newskip\e@level@five@skip  \e@level@five@skip=0ex

%
% Selecting the Levels of Headings
%

% One Level
\def\OneLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
}

% Two Levels
\def\TwoLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelfour{##1}}%
    \def\@subsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
}

% Two Levels - Variation
\def\TwoLevelHeadingA{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \let\subsection=\levelfive%
}

% Three Levels
\def\ThreeLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelfour{##1}}%
    \def\@subsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \let\subsubsection=\levelfive
}

% Four Levels
\def\FourLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\leveltwo{##1}}%
    \def\@sectionb[##1]##2{\leveltwo{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\leveltwo{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\levelthree{##1}}%
    \def\@subsectionb[##1]##2{\levelthree{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\levelthree{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \def\subsubsection{\@ifnextchar*{\@subsubsections}%
                      {\@ifnextchar[{\@subsubsectionb}{\@subsubsection}}}%
    \def\@subsubsections*##1{\levelfour{##1}}%
    \def\@subsubsectionb[##1]##2{\levelfour{##2}%
        \addcontentsline{toc}{subsubsection}{##1}}%
    \def\@subsubsection##1{\levelfour{##1}%
        \addcontentsline{toc}{subsubsection}{##1}}%
%
    \let\paragraph=\levelfive%
}

% HRI Heading Style,  MAG August 2010
\def\HRIHeadingStyle{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    %\def\@sections*##1{\levelone{##1}}%  MAG commented
    \def\@sections*##1{\levelnone{##1}}%
    \def\@sectionb[##1]##2{\levelone{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\levelone{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\leveltwo{##1}}%
    \def\@subsectionb[##1]##2{\leveltwo{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\leveltwo{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \def\subsubsection{\@ifnextchar*{\@subsubsections}%
                      {\@ifnextchar[{\@subsubsectionb}{\@subsubsection}}}%
    \def\@subsubsections*##1{\levelthree{##1}}%
    \def\@subsubsectionb[##1]##2{\levelthree{##2}%
        \addcontentsline{toc}{subsubsection}{##1}}%
    \def\@subsubsection##1{\levelthree{##1}%
        \addcontentsline{toc}{subsubsection}{##1}}%
%
    \let\paragraph=\levelfour%
    \let\subparagraph=\levelfive%
} % End of HRI Heading Style

% Five Levels
\def\FiveLevelHeading{%
    \def\section{\@ifnextchar*{\@sections}%
                {\@ifnextchar[{\@sectionb}{\@section}}}%
    \def\@sections*##1{\levelone{##1}}%
    \def\@sectionb[##1]##2{\levelone{##2}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
    \def\@section##1{\levelone{##1}%
        \@mkboth{\MakeUppercase{##1}}{\MakeUppercase{##1}}%
        \addcontentsline{toc}{section}{##1}}%
%
    \def\subsection{\@ifnextchar*{\@subsections}%
                   {\@ifnextchar[{\@subsectionb}{\@subsection}}}%
    \def\@subsections*##1{\leveltwo{##1}}%
    \def\@subsectionb[##1]##2{\leveltwo{##2}%
        \addcontentsline{toc}{subsection}{##1}}%
    \def\@subsection##1{\leveltwo{##1}%
        \addcontentsline{toc}{subsection}{##1}}%
%
    \def\subsubsection{\@ifnextchar*{\@subsubsections}%
                      {\@ifnextchar[{\@subsubsectionb}{\@subsubsection}}}%
    \def\@subsubsections*##1{\levelthree{##1}}%
    \def\@subsubsectionb[##1]##2{\levelthree{##2}%
        \addcontentsline{toc}{subsubsection}{##1}}%
    \def\@subsubsection##1{\levelthree{##1}%
        \addcontentsline{toc}{subsubsection}{##1}}%
%
    \let\paragraph=\levelfour%
    \let\subparagraph=\levelfive%
}

% Refer to LaTeX book to modify, if you want, spaces before and after of
%  \begin{...} ... \end{...} or spaces between \item-s.
\newcounter{APAenum}
\newskip\@text@par@indent
\def\APAenumerate{\@text@par@indent\parindent\setbox0\hbox{1. }%
    \list{\arabic{APAenum}.}{\usecounter{APAenum}
    \labelwidth\z@\labelsep\z@\leftmargin\z@\parsep\z@
    \rightmargin\z@\itemsep\z@\topsep\z@\partopsep\z@
    \itemindent\@text@par@indent\advance\itemindent by\wd0
    \def\makelabel##1{\hss\llap{##1 }}}}
\let\endAPAenumerate=\endlist

\def\seriate{\@bsphack\begingroup%
   \setcounter{APAenum}{0}%
   \def\item{\addtocounter{APAenum}{1}(\alph{APAenum})\space}%
   \ignorespaces}
\def\endseriate{\endgroup\@esphack}

\def\APAitemize{\@text@par@indent\parindent\setbox0\hbox{$\bullet$}%
    \list{$\bullet$}{%
    \labelwidth\z@\labelsep.5em\leftmargin\z@\parsep\z@
    \rightmargin\z@\itemsep\z@\topsep\z@\partopsep\z@
    \itemindent\@text@par@indent
    \advance\itemindent by\wd0\advance\itemindent by.5em
    \def\makelabel##1{\hss\llap{##1}}}}
\let\endAPAitemize=\endlist

\let\enumerate=\APAenumerate
\let\endenumerate=\endAPAenumerate
\let\itemize=\APAitemize
\let\enditemize=\endAPAitemize

%=============================================================
%
% End of code from theapa.sty
%
%=============================================================

%===== apa.cls main declarations for title page contents =====

\long\def\title#1{\long\def\@title{#1}}
\long\def\author#1{\long\def\@author{#1}}
\long\def\twoauthors#1#2{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@author{#1}}
\long\def\onetwoauthors#1#2#3{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@author{#1}}
\long\def\twooneauthors#1#2#3{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@author{#1}\def\@twofirst{1}}
\let\threeauthors=\onetwoauthors
\long\def\fourauthors#1#2#3#4{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%
 \long\def\@authorThree{#3}\long\def\@authorFour{#4}\long\def\@author{#1}}
\long\def\fiveauthors#1#2#3#4#5{\long\def\@authorOne{#1}\long\def\@authorTwo{#2}%%%%
 \long\def\@authorThree{#3}\long\def\@authorFour{#4}\long\def\@authorFive{#5}%    %%
 \long\def\@author{#1}} %%     2006/01/05 -- added as contributed by Aaron Geller %%
\long\def\sixauthors#1#2#3#4#5#6{\long\def\@authorOne{#1}%                  %% thp 2006/01/05
 \long\def\@authorTwo{#2}\long\def\@authorThree{#3}\long\def\@authorFour{#4}%% thp 2006/01/05
 \long\def\@authorFive{#5}\long\def\@authorSix{#6}\long\def\@author{#1}}    %% thp 2006/01/05 
\long\def\affiliation#1{\long\def\@affil{#1}}
\long\def\twoaffiliations#1#2{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
\long\def\@affil{#1}}
\long\def\onetwoaffiliations#1#2#3{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affil{#1}}
\long\def\twooneaffiliations#1#2#3{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affil{#1}}
\let\threeaffiliations=\onetwoaffiliations
\long\def\fouraffiliations#1#2#3#4{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%
 \long\def\@affilThree{#3}\long\def\@affilFour{#4}\long\def\@affil{#1}}
\long\def\fiveaffiliations#1#2#3#4#5{\long\def\@affilOne{#1}\long\def\@affilTwo{#2}%%
 \long\def\@affilThree{#3}\long\def\@affilFour{#4}\long\def\@affilFive{#5}%        %%
 \long\def\@affil{#1}} %%     2006/01/05 -- added as contributed by Aaron Geller   %%
\long\def\sixaffiliations#1#2#3#4#5#6{\long\def\@affilOne{#1}%           %% thp 2006/01/05
 \long\def\@affilTwo{#2}\long\def\@affilThree{#3}\long\def\@affilFour{#4}%% thp 2006/01/05
 \long\def\@affilFive{#5}\long\def\@affilSix{#6}\long\def\@affil{#1}}    %% thp 2006/01/05
\long\def\note#1{\long\def\@note{#1}}
\long\def\abstract#1{\long\def\@abstract{#1}}
\long\def\acknowledgements#1{\long\def\@acks{#1}}

% Mike Goodrich: Options for HRI Journal.  August 2010
\long\def\keywords#1{\long\def\@keywords{#1}}
\long\def\field#1{\long\def\@field{#1}}
\long\def\contribution#1{\long\def\@contribs{#1}}
\long\def\COI#1{\long\def\@COI{#1}}
\long\def\uniqueness#1{\long\def\@uniqueness{#1}}
%\def\NoSectionNumbering#1{\def\@NoSectionNumbering{}}
% End HRI Journal options


\def\journal#1{\RequirePackage{fancyhdr}\def\@journal{#1}}
\def\volume#1{\def\@vvolume{#1}}
\def\ccoppy#1{\def\@ccoppy{#1}}
\def\copnum#1{\def\@copnum{#1}}
\def\@error@toomanyauthors{\ClassWarningNoLine{apa}{More authors than affiliations defined}}
\def\@error@toomanyaffils{\ClassWarningNoLine{apa}{More affiliations than authors defined}}
\def\check@author{%
 \@ifundefined{@author}{%
  \ClassWarningNoLine{apa}{Author not defined}\def\@author{Author}}{}
 \@ifundefined{@title}{%
  \ClassWarningNoLine{apa}{Title not defined}\def\@title{Title}}{}
 \@ifundefined{@affil}{%
  \ClassWarningNoLine{apa}{Affiliation not defined}\def\@affil{Affiliation}}{}
 \@ifundefined{@abstract}{%
  \ClassWarningNoLine{apa}{Abstract not defined}}{}
 \@ifundefined{@authorSix}{%                                   % -- thp 2006/01/05
  \@ifundefined{@authorFive}{%                                 % -- thp 2006/01/05
   \@ifundefined{@authorFour}{%
    \@ifundefined{@authorThree}{%
     \@ifundefined{@authorTwo}{%
     }{\@ifundefined{@affilTwo}{\@error@toomanyauthors}{}}
    }{\@ifundefined{@affilThree}{\@error@toomanyauthors}{}}
   }{\@ifundefined{@affilFour}{\@error@toomanyauthors}{}}
  }{\@ifundefined{@affilFive}{\@error@toomanyauthors}{}}       % -- thp 2006/01/05
 }{\@ifundefined{@affilSix}{\@error@toomanyauthors}{}}         % -- thp 2006/01/05
 \@ifundefined{@affilSix}{%                                    % -- thp 2006/01/05
  \@ifundefined{@affilFive}{%                                  % -- thp 2006/01/05
   \@ifundefined{@affilFour}{%
    \@ifundefined{@affilThree}{%
     \@ifundefined{@affilTwo}{%
     }{\@ifundefined{@authorTwo}{\@error@toomanyaffils}{}}
    }{\@ifundefined{@authorThree}{\@error@toomanyaffils}{}}
   }{\@ifundefined{@authorFour}{\@error@toomanyaffils}{}}
  }{\@ifundefined{@authorFive}{\@error@toomanyaffils}{}}       % -- thp 2006/01/05
 }{\@ifundefined{@authorSix}{\@error@toomanyaffils}{}}         % -- thp 2006/01/05
}

%==== Conditional compilation macros depending on mode ====

\long\def\ifapamodeman#1#2{\@ifundefined{def@man}{#2}{#1}}
\long\def\ifapamodejou#1#2{\@ifundefined{def@jou}{#2}{#1}}
\long\def\ifapamodedoc#1#2{\@ifundefined{def@doc}{#2}{#1}}
\long\def\ifapamode#1#2#3{%
 \@ifundefined{def@man}{%
  \@ifundefined{def@jou}{%
   \@ifundefined{def@doc}{\ClassError{apa}{Undefined mode state!}}{#3}%
  }{#2}%
 }{#1}%
}

%==== Automatic figure size and orientation determination ====

\newsavebox\gr@box
\newlength\gr@boxwidth
\newlength\gr@boxheight

\newcommand{\fitfigure}[2][0.5]{%
\ifapamodeman
{% man
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settowidth{\gr@boxwidth}{\usebox\gr@box}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\gr@boxwidth{% display upright (h)
 \ifdim\gr@boxheight>\textheight%
  \centerline{\vspace{\fill}\includegraphics[height=\textheight]{#2}\vspace{\fill}}%
 \else%
  \usebox\gr@box%
 \fi}
\else{% display rotated
 \sbox\gr@box{\includegraphics[angle=90,width=\linewidth]{#2}}
 \settoheight{\gr@boxheight}{\usebox\gr@box}
 \ifdim\gr@boxheight>\textheight%
  \centerline{\vspace{\fill}\includegraphics[angle=90,height=\textheight]{#2}\vspace{\fill}}%
 \else%
  \usebox\gr@box%
 \fi}
\fi}
{% jou, doc, HRI  % MAG: jou, doc --> jou, doc, HRI
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\textheight%
 \centerline{\includegraphics[height=#1\textheight]{#2}}% need to leave space for caption
\else%
 \usebox\gr@box%
\fi}
}

\newcommand{\fitbitmap}[2][0.5]{ % like fitfigure but no scaling in man mode for best quality
\ifapamodeman
{% man
\sbox\gr@box{\includegraphics{#2}}
\settowidth{\gr@boxwidth}{\usebox\gr@box}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxwidth>\textwidth% display rotated
  \centerline{\vspace{\fill}\includegraphics[angle=90]{#2}\vspace{\fill}}%
  \ifdim\gr@boxheight>\textwidth\ClassWarning{apa}{Figure #2 too high!}\fi% display rotated
  \ifdim\gr@boxwidth>\textheight\ClassWarning{apa}{Figure #2 too wide!}\fi% display rotated
\else% display upright
  \centerline{\vspace{\fill}\includegraphics{#2}\vspace{\fill}}%
  \ifdim\gr@boxheight>\textheight\ClassWarning{apa}{Figure #2 too high!}\fi% display rotated
\fi}
{% jou, doc, HRI  % MAG: jou, doc --> jou, doc, HRI
\sbox\gr@box{\includegraphics[width=\linewidth]{#2}}
\settoheight{\gr@boxheight}{\usebox\gr@box}
\ifdim\gr@boxheight>\textheight%
 \centerline{\includegraphics[height=#1\textheight]{#2}}% need to leave space for caption
\else%
 \centerline{\usebox\gr@box}%
\fi}
}

%==== Miscellaneous definitions

\let\normal@BBAB\BBAB                        % -- thp 2005/07/23
\let\table@BBAB\BBAA                         % -- thp 2005/07/23

\setlength{\doublerulesep}{\arrayrulewidth}
\newcommand\thickline{\hline\hline}
\renewcommand\footnoterule{%
  \kern-3\p@
%  \hrule.5\@width.4\columnwidth
  \hrule height0.125pt width.5in
  \kern2.6\p@}

\let\old@tabular\tabular
\def\apatabular#1{\def\@halignto{to\linewidth}%
 \let\BBAB\table@BBAB%                         -- thp 2005/07/23
 \@tabular{@{\extracolsep{\fill}}#1}}
\def\apa@doc@tabular{%% thp 2006/01/02
 \let\BBAB\table@BBAB%% Erik Meijer noticed that in doc mode tables weren't centered
 \hfill\old@tabular} %% and that the in-table citation form was incorrect 
%%
\let\orig@endtabular\endtabular              % -- thp 2005/07/23
\def\endtabular{%
 \let\BBAB\normal@BBAB%                        -- thp 2005/07/23
 \orig@endtabular\ifapamodedoc{\hfill}{}}% 2006/01/02 \hfill for centering in doc mode
\def\apa@doc@endtabular{%% thp 2006/01/03
 \let\BBAB\normal@BBAB% %% separate redefinition of tabular/endtabular for doc mode
 \orig@endtabular\hfill}%% to ensure centering, especially in case array.sty is loaded

% Define footnote mark commands for tables that won't mess up vertical alignment
\def\@tab@fn#1{\ensuremath{^{\mbox{{\scriptsize #1}}}}}
\def\tabfnm#1{\rlap{\@tab@fn{#1}}}
\def\tabfnt#1#2{\par\raggedright\@tab@fn{#1}#2}

% Provide a command to display vector symbols appropriately in each mode, thp 10/00
% Use improved definition of apavector provided by Erik Meijer -- 2005/12/28
\def\apavector#1{{\ensuremath
  \uprightlowercasegreek
  \ifapamodeman
  {\apasmash{\mathop{\kern\z@\mathrm{#1}}\limits_{\scriptscriptstyle\sim}}}%
  {\if@bm@loaded\bm{\mathrm{#1}}\else\mathbf{#1}\fi% in case bm is not available
  }%
}}
% and here are the necessary definitions & packages, as instructed by Erik Meijer
\newcommand{\apasmash}{%
  \def\finsm@sh{\dp\z@\z@ \box\z@}%
  \expandafter\mathpalette\expandafter\mathsm@sh
}%
\newif\if@bm@loaded\@bm@loadedfalse
\IfFileExists{bm.sty}{\RequirePackage{bm}\@bm@loadedtrue}{}% if not, apavector will fail
\newcommand{\uprightlowercasegreek}{%
  \@ifundefined{alphaup}{}{%
    \def\alpha     {\alphaup     }%
    \def\beta      {\betaup      }%
    \def\gamma     {\gammaup     }%
    \def\delta     {\deltaup     }%
    \def\epsilon   {\epsilonup   }%
    \def\varepsilon{\varepsilonup}%
    \def\zeta      {\zetaup      }%
    \def\eta       {\etaup       }%
    \def\theta     {\thetaup     }%
    \def\vartheta  {\varthetaup  }%
    \def\iota      {\iotaup      }%
    \def\kappa     {\kappaup     }%
    \def\lambda    {\lambdaup    }%
    \def\mu        {\muup        }%
    \def\nu        {\nuup        }%
    \def\xi        {\xiup        }%
    \def\pi        {\piup        }%
    \def\varpi     {\varpiup     }%
    \def\rho       {\rhoup       }%
    \def\varrho    {\varrhoup    }%
    \def\sigma     {\sigmaup     }%
    \def\varsigma  {\varsigmaup  }%
    \def\tau       {\tauup       }%
    \def\upsilon   {\upsilonup   }%
    \def\phi       {\phiup       }%
    \def\varphi    {\varphiup    }%
    \def\chi       {\chiup       }%
    \def\psi       {\psiup       }%
    \def\omega     {\omegaup     }%
  }%
}
\let\apamatrix\apavector

%==== Appendix macros added by Michael Erickson 2000/07/11, revised by thp 2000/07/18

\newcounter{appendix}\setcounter{appendix}{0}
\renewcommand{\theappendix}{\@Alph\c@appendix} 
\def\apaappfig{%
 \renewcommand\thefigure{\theappendix\@arabic\c@figure}% 
 \ifapamodeman{\renewcommand\thepostfig{\theappendix\arabic{postfig}}}{}}
\def\apaapptab{%
 \renewcommand\thetable{\theappendix\@arabic\c@table}%
 \ifapamodeman{\renewcommand\theposttbl{\theappendix\arabic{posttbl}}}{}}
\newif\ifoneappendix            
\oneappendixtrue % one appendix by default
\newif\ifappendix
\appendixfalse

\def\appendix{%
  \appendixtrue
  \apaappfig                      
  \apaapptab                      
%  \ifapamodejou{}{\clearpage} %% commented out -- thp 2005/07/23
  \let\old@apa@section=\leveltwo % This will not work right with five levels in appendix.
                                 % Should go into \section, not \leveltwo but would also require
                                 % changes to section* and section[ (see \def\section above)
                                 % Who uses five level heading appendices anyway?
  \newlength{\app@t@width}
  \setlength{\app@t@width}{\columnwidth}
  \addtolength{\app@t@width}{-8em}%% leveltwo is defined with leftskip=rightskip=4em plus 1fill
  \long\def\leveltwo##1{%
                   \ifapamodeman{%
                    \clearpage
                    \setcounter{postfig}{0}
                    \setcounter{posttbl}{0}
                    \efloat@condopen{fff}
                    \efloat@iwrite{fff}{\string\addtocounter{appendix}{1}}
                    \efloat@iwrite{fff}{\string\setcounter{figure}{0}}
                    \efloat@condopen{ttt}
                    \efloat@iwrite{ttt}{\string\addtocounter{appendix}{1}}
                    \efloat@iwrite{ttt}{\string\setcounter{table}{0}}%
                   }{%
                    \setcounter{figure}{0}%
                    \setcounter{table}{0}%
%                    %\small% the appendix should be set in smaller type in jou, including headers!
                   }%
%                  \addtocounter{appendix}{1}%
                   \refstepcounter{appendix}% 2002/07/20 this takes care of references too
                   \ifnum\c@appendix>1\immediate\write\@auxout{\global\string\oneappendixfalse}\fi%
                   \old@apa@section{%
                      \old@tabular[t]{@{}p{\app@t@width}@{}}% tabular may have been redefined
                         \centering{%
                          \appendixname\ifoneappendix\else~\theappendix\fi\\
                          ##1%
                      }\endtabular
                   }%
                  }%
} % end of appendix definition

%==== End of general apa.cls macro definitions ====


%%%%%%%%%%%%%%%%%%%%%%%
%                     %
%  MANUSCRIPT FORMAT  %
%                     %
%%%%%%%%%%%%%%%%%%%%%%%

\@ifundefined{def@man}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase{\expandafter{#1}}}}    % <- \bf % thp 17Aug08
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\@ifundefined{no@bf@title}{\bf}{} #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\em #1}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}. \hskip .5em plus 1pt minus .5pt}} %% added space and moved skip inside -- thp 081113

%========== End of code from theapa.sty ===============

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{#1}}}
\def\leftheader#1{\def\r@headl{#1}}
\def\shorttitle#1{\def\s@title{#1}}%\markright{\hfill #1 \thepage} %% no rm - thp 020227

\def\@@spacing{1.75}

%========== Alterations to endnotes ===================

\RequirePackage{endnotes}

\def\@makeenmark{\hbox{$^{\mbox{\small\@ifundefined{hrm}{}{\sf}\@theenmark}}$}}
\def\enoteformat{\rightskip\z@ \leftskip\z@
     \raggedright\fussy\hyphenpenalty 10000 \parindent=0.4in 
     \leavevmode\llap{\hbox{$^{\mbox{\small\@ifundefined{hrm}{}{\sf}\@theenmark}}$}}}
\AtEndDocument{%
 \ifappendix% set section back to no numbering after appendix
  \appendixfalse\let\leveltwo=\old@apa@section%
 \fi
 \@ifundefined{@acks}{}{\newpage\section{\acksname}\@acks}
 \@ifundefined{hrm}{\def\enotesize{\normalsize}}
                   {\def\enotesize{\normalsize\@ifundefined{hrm}{}{\sf}}}
 \@ifundefined{NoEndnotes}{\if@enotesopen\newpage\theendnotes\fi}{}
 \let\footnote=\oldfootnote
}

%========= Alterations to endfloat ====================

\@ifundefined{float@mark}{% Figure and table in-text markers are no longer required
 \RequirePackage[notablist,figlist,notabhead,nofighead,tablesfirst,nomarkers]{endfloat}[1995/10/11]}{%
 \RequirePackage[notablist,figlist,notabhead,nofighead,tablesfirst]{endfloat}[1995/10/11]}

\renewcommand{\figureplace}{%
   \par\begin{center}
   \parbox{\textwidth}
   {\begin{center}
   \rule{2.1in}{0.005in}\\
   Insert \figurename~\thepostfig\ about here\\
   \rule{2.1in}{0.005in}\\
   \end{center}}
   \end{center}\par}
\renewcommand{\tableplace}{%
   \par\begin{center}
   \parbox{\textwidth}
   {\begin{center}
   \rule{2.1in}{0.005in}\\
   Insert \tablename~\theposttbl\ about here\\
   \rule{2.1in}{0.005in}\\
   \end{center}}
   \end{center}\par}

\def\@gobbleuntilnext[#1]{}
\let\eatarg\@gobbleuntilnext
\let\ifnextchar\@ifnextchar

\def\figure{%
     \efloat@condopen{fff}
     \efloat@iwrite{fff}{\string\begin{figure*}[ht]}%
     \global\def\@figure@written{\relax}% Set a flag that there is at least one figure -- thp 20010705 
%% should be a global declaration to be "visible" at end document
     \ifnextchar[{\gobbleuntilnext[}{}
     \efloat@iwrite{fff}{\string\ifnextchar[{\string\eatarg}{}}
    \if@domarkers%
       \addtocounter{postfig}{1}% % bj
       \figureplace%              % bj
    \fi%
    \def\@currenvir{efloat@float}%
    \begingroup%
    \let\do\ef@makeinnocent \dospecials%
    \ef@makeinnocent\^^L% and whatever other special cases
    \endlinechar`\^^M \catcode`\^^M=12 \ef@xfigure}%

\def\table{%
    \efloat@condopen{ttt}
    \efloat@iwrite{ttt}{\string\begin{table*}[ht]}%
    \ifnextchar[{\gobbleuntilnext[}{}
    \@ifundefined{hrm}{}{%
    \efloat@iwrite{ttt}{\string\sf}}%
    \efloat@iwrite{ttt}{\string\ifnextchar[{\string\eatarg}{}} % bj
    \if@domarkers
       \addtocounter{posttbl}{1} % bj
       \tableplace               % bj
    \fi
    \def\@currenvir{efloat@float}%
    \begingroup
    \let\do\ef@makeinnocent \dospecials
    \ef@makeinnocent\^^L% and whatever other special cases
    \endlinechar`\^^M \catcode`\^^M=12 \ef@xtable}

\long\def\@@contentsline#1#2#3{ #2 }
\long\def\@@numberline#1#2{\noindent{\em\figurename\ #1.\/} #2\vspace{0.5\baselineskip}\par}
\long\def\@@caption{\refstepcounter\@captype \@dblarg{\@@@caption\@captype}}
\long\def\@@@caption#1[#2]#3{\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}}
\def\listoffigures{\section*{\figurecaptionsname}\@starttoc{lof}}% changed from 'Figure Captions'

\long\def\figurecaptionsformat{
  \let\contentsline=\@@contentsline
  \let\numberline=\@@numberline
  \def\baselinestretch{\@@spacing}
}

\def\processfigures{%
 \expandafter\ifnum \csname @ef@fffopen\endcsname>0
  \immediate\closeout\efloat@postfff \ef@setct{fff}{0}
  \clearpage                                                       
  \if@figlist
   \@ifundefined{@figure@written}{}{%
    \figurecaptionsformat
    {\normalsize\@ifundefined{hrm}{}{\sf}%
     \let\BBAB\table@BBAB% -- thp 2005/07/23
     \listoffigures%
     \let\BBAB\normal@BBAB% -- thp 2005/07/23
    }          
    \clearpage
   }                             
  \fi
  \if@fighead
     \section*{\figuresection}                                  
     \suppressfloats[t]                                         
  \fi
  \@ifundefined{fig@num}{%
  \markboth{}{}
  \pagestyle{empty}}{%
%  \setcounter{page}{1}
%  \markright{\rm\hfill \s@title, Figure}
   \def\@oddhead{\rightmark}                                    % changed by Michael Erickson
   \markright{\hfill \s@title, \figurename\ \protect\thefigure} % to include appendix numbering
                                                                % remove rm - thp 020227
  }
  \let\caption=\@@caption
  \def\baselinestretch{\@@spacing}\normalsize\@ifundefined{hrm}{}{\sf}
  \processfigures@hook \@input{\jobname.fff}
 \fi}

\def\processtables{%
  \expandafter\ifnum \csname @ef@tttopen\endcsname>0
  \immediate\closeout\efloat@postttt \ef@setct{ttt}{0}
  \clearpage                                                    
  \if@tabhead
      \section*{\tablesection}                                 
      \suppressfloats[t]                                       
  \fi
  \def\baselinestretch{\@@spacing}
  \processtables@hook \@ifundefined{hrm}{}{\sf}%
  \tiny\normalsize%
% We need to deal with citation alterations here because otherwise we either
% lose the definition through the .ttt diversion or we miss the table*
  \let\BBAB\table@BBAB%  -- thp 2005/07/23
  \@input{\jobname.ttt}%
  \let\BBAB\normal@BBAB% -- thp 2005/07/23
 \fi}

%========= Maketitle, margins, lengths, etc. ==========

\def\maketitle{
\@ifundefined{hrm}{}{\hrm}
 \check@author
 \@ifundefined{s@title}{\ClassWarningNoLine{apa}{Using title for short title}
                        \def\s@title{\@title}
                        \markright{\hfill\@title}}%\protect\thepage}}  %% removed rm
                       {\markright{\hfill\s@title}}%\protect\thepage}} %% thp 020227
 \@ifundefined{r@headr}{\ClassWarningNoLine{apa}{Using short title for running head}
                        \def\r@headr{\protect\MakeUppercase{\s@title}}}{}
  \begin{center}
  \vspace*{0.5in}
  \makebox[\linewidth][l]{\rheadname\hspace{0.1in}\MakeUppercase{\r@headr}}\\ %thp090298

  \vspace*{1in}
  \@title\vspace{0.5in}\\

  \@ifundefined{@authorTwo}{
  \@author \\

  \@affil \vspace{0.25in} \\ }{
  \@ifundefined{@authorThree}{
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.25in} \\ }{
  \@ifundefined{@authorFour}{
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.25in} \\ }{
  \@ifundefined{@authorFive}{       %% 2006/01/05 added as contributed by Aaron Geller
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.2in} \\ 
  \@authorFour \\

  \@affilFour \vspace{0.25in} \\ }{ %% 2006/01/05 beginning of Aaron Geller contribution
  \@ifundefined{@authorSix}{ %% -- thp 2006/01/05
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.2in} \\ 
  \@authorFour \\

  \@affilFour \vspace{0.2in} \\ %% thp corrected distance to non-final value of 0.2in
  \@authorFive \\

  \@affilFive \vspace{0.25in} \\ }{%% 2006/01/05 end of Aaaron Geller contribution
%% --- thp 2006/01/05 beginning of six-author display
  \@authorOne \\

  \@affilOne \vspace{0.2in} \\
  \@authorTwo \\

  \@affilTwo \vspace{0.2in} \\
  \@authorThree \\

  \@affilThree \vspace{0.2in} \\ 
  \@authorFour \\

  \@affilFour \vspace{0.2in} \\
  \@authorFive \\

  \@affilFive \vspace{0.2in} \\
  \@authorSix \\

  \@affilSix \vspace{0.25in} \\ }}}}}
%% --- thp 2006/01/05 end of six-author display
  \@ifundefined{@note}
   {\vspace*{\baselineskip} }
   {\@note}

  \end{center}
  \newpage
  \raggedright
  \hyphenpenalty 10000
  \fussy
  \@ifundefined{@abstract}{}{%
   \section{\abstractname}% changed from 'Abstract' 10/00

   \@abstract

   \newpage
  }
  \setlength{\parindent}{0.4in}
  \@ifundefined{DoNotRepeatTitle}{\section{\protect\@title}}{}

  \indent
}

\ThreeLevelHeading
\def\baselinestretch{\@@spacing}
\setlength{\footnotesep}{0.5cm}
\setlength{\topmargin}{0in}
\setlength{\oddsidemargin}{0.25in}
\setlength{\evensidemargin}{0.25in}
\setlength{\textwidth}{6in}
\setlength{\textheight}{8.5in}
\setcounter{secnumdepth}{0}

\def\ps@myheadings{
 \let\@mkboth\@gobbletwo
 \def\@oddhead{\hbox{}\rightmark\hfil\hspace{0.1in}\thepage} %% removed rm - thp 020227
 \def\@oddfoot{}
 \def\@evenhead{}
 \def\@evenfoot{}
 \def\sectionmark##1{}
 \def\subsectionmark##1{}}

\pagestyle{myheadings}
\raggedright
\hyphenpenalty 10000
\newcommand{\footmark}[1]{${}^{\mbox{\normalsize #1}}$}

\long\def\@makecaption#1#2{%
 \let\BBAB\table@BBAB % thp 2005/07/23
 \vskip10pt%
 \setbox\@tempboxa\hbox{\parbox{\columnwidth}{#1\cap@line{\cap@style #2}}}%
 \ifdim\wd\@tempboxa>\hsize\parbox{\columnwidth}{#1\cap@line{\cap@style #2}}\par%
 \else\hbox to\hsize{\box\@tempboxa\hfil}\par%
 \fi%
 \let\BBAB\normal@BBAB % thp 2005/07/23
 \vskip\baselineskip}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize\@ifundefined{hrm}{}{\hrm}
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3 } \par
  \endgroup}

\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}

\def\centeredcaption#1{\caption}

\def\fnum@figure{\def\cap@style{}\def\cap@line{}{\em\figurename\ {\thefigure}}. }
% added second set of braces around \em  to get citations in man mode -- tp 17/7/2000
% then removed them again because they were cancelling application of em to the caption
\long\def\fnum@table{\def\cap@style{\em}\def\cap@line{\\ }\tablename\ \thetable }

\setcounter{topnumber}{1}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.6}
\setcounter{totalnumber}{1}
\def\textfraction{0}
\def\floatpagefraction{.7}
\setcounter{dbltopnumber}{1}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.7}
\def\dbltextfloatsep{\textfloatsep}

\fussy
\setlength{\parindent}{0.4in}
\let\oldfootnote=\footnote % 3/10/00 
\let\footnote=\endnote
\def\footnotesize{\normalsize\rm}

\@ifundefined{def@nosf}{%
\def\helvetica{%
\ClassWarning{apa}{ignored \string\helvetica\space (use helv option)}
}}{\def\helvetica{\relax}}

%==== Appendix definitions added by Michael Erickson 2000/07/11

\efloat@condopen{fff}
\efloat@iwrite{fff}{\string\apaappfig}
\efloat@iwrite{fff}{\string\setcounter{appendix}{0}}
\efloat@condopen{ttt}
\efloat@iwrite{ttt}{\string\apaapptab}
\efloat@iwrite{ttt}{\string\setcounter{appendix}{0}}

}% end of man mode (manuscript format)


%%%%%%%%%%%%%%%%%%
%                %
% JOURNAL FORMAT %
%                %
%%%%%%%%%%%%%%%%%%

\@ifundefined{def@jou}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase{\expandafter{\large #1}}}}    % <- \bf  % thp 17Aug08
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     {\large #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\large{\em #1}}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{\large{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}. \hskip .5em plus 1pt minus .5pt}} %% added space and moved skip inside -- thp 081113

%========== End of code from theapa.sty ===============

%========== balance last-page columns ================= 

\IfFileExists{flushend.sty}{\RequirePackage{flushend}}{}

%========== ftnright and alterations ==================

\IfFileExists{ftnright.sty}{
 \let\savefootnoterule\footnoterule
 \let\save@makefntext\@makefntext
 \RequirePackage{ftnright}
 \let\footnoterule\savefootnoterule
 \let\@makefntext\save@makefntext
}{}

%======================================================

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{\protect\scriptsize #1}}}
\def\leftheader#1{\def\r@headl{\protect\MakeUppercase{\protect\scriptsize #1}}}
\def\shorttitle#1{}

\def\put@one@authaffil#1#2{%
  \parbox[t]{\textwidth}{\begin{center}{\large #1\vspace{0in}}%
                        {\\ #2\vspace{0.05in}\\}\end{center}}}

\newsavebox\auone@box
\newsavebox\autwo@box
\newsavebox\autot@box
\newlength\auone@boxwidth
\newlength\autwo@boxwidth
\newlength\autot@boxwidth

\def\default@d@authaffil#1#2#3#4{%
        \parbox[t]{\columnwidth}{\begin{center}{\large #1\vspace{0in}}%
                                {\\ #2\vspace{0.05in}\\}\end{center}}%
        \parbox[t]{\columnwidth}{\begin{center}{\large #3\vspace{0in}}%
                                {\\ #4\vspace{0.05in}\\}\end{center}}}

\def\uneven@d@authaffil#1#2#3#4{%
     \hfill\parbox[t]{\auone@boxwidth}{\begin{center}{\large #1\vspace{0in}}%
                                      {\\ #2\vspace{0.05in}\\}\end{center}}\hfill\hfill%
           \parbox[t]{\autwo@boxwidth}{\begin{center}{\large #3\vspace{0in}}%
                                      {\\ #4\vspace{0.05in}\\}\end{center}}\hfill}

\def\put@two@authaffil#1#2#3#4{%
     \let\disp@authaffil\default@d@authaffil
     \sbox\auone@box{\begin{tabular}{c}\large #1\\ #2\end{tabular}}
     \settowidth{\auone@boxwidth}{\usebox\auone@box}
     \sbox\autwo@box{\begin{tabular}{c}\large #3\\ #4\end{tabular}}
     \settowidth{\autwo@boxwidth}{\usebox\autwo@box}
     \ifdim\auone@boxwidth<1.25\columnwidth
      \ifdim\autwo@boxwidth<1.25\columnwidth
       \sbox\autot@box{\usebox\auone@box\hspace{0.4in}\usebox\autwo@box}
       \settowidth{\autot@boxwidth}{\usebox\autot@box}
       \ifdim\autot@boxwidth<\textwidth
        \let\disp@authaffil\uneven@d@authaffil
       \fi
      \fi
     \fi
     \ifdim\auone@boxwidth<\columnwidth
      \ifdim\autwo@boxwidth<\columnwidth
       \let\disp@authaffil\default@d@authaffil
      \fi
     \fi
     \disp@authaffil{#1}{#2}{#3}{#4}
}

\def\maketitle{
 \check@author
 \@ifundefined{r@headr}{\def\r@headr{\protect\MakeUppercase{\protect\scriptsize\@title}}}{}
 \@ifundefined{r@headl}{\def\r@headl{\protect\MakeUppercase{\protect\scriptsize\@author}}}{}
 \twocolumn[
  \vspace{0.03in}
  \begin{center}
% title
  {\LARGE \@title}\\
  \vspace{-0.05in}
  \@ifundefined{@authorTwo}{
% one author-affiliation
  \put@one@authaffil{\@author}{\@affil}}{
  \@ifundefined{@authorThree}{
% two authors-affiliations
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}}{
  \@ifundefined{@authorFour}{
% three authors-affiliations
  \@ifundefined{@twofirst}{
% first one, then two
  \put@one@authaffil{\@authorOne}{\@affilOne}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorTwo}{\@affilTwo}{\@authorThree}{\@affilThree}
  }{
% first two, then one
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@one@authaffil{\@authorThree}{\@affilThree}
  }}{
  \@ifundefined{@authorFive}{ % 2006/01/05 as contributed by Aaron Geller
% four authors-affiliations
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorThree}{\@affilThree}{\@authorFour}{\@affilFour}
  }{                          % 2006/01/05 beginning of Aaron Geller contribution
  \@ifundefined{@authorSix}{ % -- thp 2006/01/05
% five authors-affiliations
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorThree}{\@affilThree}{\@authorFour}{\@affilFour}%
  \vspace{-0.15in}\\ % thp added negative vertical space
  \put@one@authaffil{\@authorFive}{\@affilFive}
  }{                          % 2006/01/05 end of Aaron Geller contribution
% six authors-affiliations
%% --- thp 2006/01/05 beginning of six-author display
  \put@two@authaffil{\@authorOne}{\@affilOne}{\@authorTwo}{\@affilTwo}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorThree}{\@affilThree}{\@authorFour}{\@affilFour}\vspace{-0.15in}\\
  \put@two@authaffil{\@authorFive}{\@affilFive}{\@authorSix}{\@affilSix}
%% --- thp 2006/01/05 end of six-author display
  }}}}}
  \@ifundefined{@note}
   {\vspace{0.07in}}
   {\vspace{0.07in}\\ {\large\@note\vspace{0.07in}}}
  \@ifundefined{@abstract}
  {\par }
  {\par \parbox{4.6875in}
   {\small \noindent \@abstract
   }\vspace{0.24in}
  }
  \end{center}
 ]
 \pagenumbering{arabic}
 \@ifundefined{@journal}{\thispagestyle{empty}}{%
  \@ifundefined{@vvolume}{\def\@vvolume{\strut}}{}%
  \@ifundefined{@copnum}{\def\@copnum{\strut}}{}%
  \@ifundefined{@ccoppy}{\def\@ccoppy{\strut}}{}%
  \fancyhead{}
  \fancyhead[LO]{\stiny{\@journal}\vspace{-0.15\baselineskip}\\
                 \stiny{\@vvolume}}
  \fancyhead[RO]{\stiny{\@ccoppy}\vspace{-0.15\baselineskip}\\
                 \stiny{\@copnum}}
  \fancyfoot[CO]{\small\rm\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \thispagestyle{fancy}
 }
 \@ifundefined{@acks}
  {}
  {\begin{figure}[b]
   \parbox{\columnwidth}{\setlength{\parindent}{0.18in}
   \noindent\makebox[\columnwidth]{\vrule height0.125pt width\columnwidth}\vspace*{0.05in}\par
   {\footnotesize\hspace{-0.04in}\@acks\par}}
   \end{figure}}
 \markboth{\hfill\r@headl\hfill}{\hfill\r@headr\hfill}
 \@ifundefined{no@tab}{\let\tabular\apatabular}{}
 \noindent
}

\newcommand\stiny{\@setfontsize\stiny\@vipt\@viipt}

\ThreeLevelHeading
\def\baselinestretch{0.923}
%\def\refname{References}
\setlength{\footnotesep}{0.2813in}
\setlength{\topmargin}{-0.275in}
\addtolength{\headheight}{0.02in}
\addtolength{\headsep}{-0.156in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\textwidth}{6.94in}
\setlength{\textheight}{8.9in}
\setlength{\columnwidth}{8.5cm}
\setlength{\columnsep}{0.25in}
\setlength{\parindent}{0.15625in}
%\setlength{\parskip}{0in}
\setlength{\textfloatsep}{0.35in}
%\flushbottom

\setcounter{secnumdepth}{0}

\def\ps@myheadings{\let\@mkboth\@gobbletwo
\def\@oddhead{\hbox{}\rightmark \hfil
\large\rm\thepage}\def\@oddfoot{}\def\@evenhead{\large\rm \thepage\hfil\leftmark\hbox
{}}\def\@evenfoot{}\def\sectionmark##1{}\def\subsectionmark##1{}}
\pagestyle{myheadings}

\long\def\@makecaption#1#2{%
  \let\BBAB\table@BBAB % thp 2005/07/23
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1 #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1 #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \let\BBAB\normal@BBAB % thp 2005/07/23
  \vskip\belowcaptionskip}

\long\def\@makeccaption#1#2#3{
 \let\BBAB\table@BBAB % thp 2005/07/23
 \vskip\abovecaptionskip
 \setbox\@tempboxa\hbox{#1 #2}
 \ifdim \wd\@tempboxa > \hsize 
    \hbox to\hsize{\hfil\parbox[t]{#3}{#1 #2}\hfil} 
  \else 
    \ifdim \wd\@tempboxa > #3
      \hbox to\hsize{\hfil\parbox[t]{#3}{#1 #2}\hfil}
    \else
      \hbox to\hsize{\hfil\mbox{#1 #2}\hfil} 
    \fi
 \fi 
 \let\BBAB\normal@BBAB % thp 2005/07/23
 \vskip\belowcaptionskip}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \csname setcskip@#1\endcsname
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\long\def\@ccaption#1[#2]#3#4{\def\@ccwidth{#3} \par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makeccaption{\csname fnum@#1\endcsname}{\ignorespaces #4}{\@ccwidth}\par
  \endgroup}

\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}

\long\def\centeredcaption{\refstepcounter\@captype \@dblarg{\@ccaption\@captype}}

\def\setcskip@table{\setlength{\abovecaptionskip}{3.2pt}\setlength{\belowcaptionskip}{2pt}}
\def\setcskip@figure{\setlength{\abovecaptionskip}{-0.04in}\setlength{\belowcaptionskip}{-1.9pt}}

\def\fnum@figure{\small{\em\figurename\ {\thefigure}}.\hspace{0.07in}}
\long\def\fnum@table{\makebox[\linewidth][l]{\tablename\ \thetable} \\ \em }

\def\@makefnmark{\hbox{\@textsuperscript{\normalfont{\scriptsize\@thefnmark}}}}%
\long\def\@makefntext#1{\parindent 1em\noindent
           \hb@xt@1.8em{%
           \hss\@textsuperscript{\normalfont{\tiny\@thefnmark}\hspace{1.5pt}}}#1}%

\setcounter{topnumber}{2}
\def\topfraction{.85}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.75}
\setcounter{totalnumber}{3}
\def\textfraction{.10}
\def\floatpagefraction{.85}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.85}
\def\dblfloatpagefraction{.85}
\def\dbltextfloatsep{0.8\textfloatsep}
\let\footnotesize=\small

\def\helvetica{\relax}

\doublehyphendemerits5000
\hfuzz0pt
\tolerance=9999
\pretolerance=-1
\emergencystretch=25pt
\hbadness=30000
\hyphenpenalty=100




\@ifundefined{def@noapacite}{% -- Philip Kime 2008/12/03
  % Removed some bibliography redefinitions as per the instructions of Erik Meijer 
  \bibleftmargin=1.2em        % left these in because the default is too big
  \bibindent=-\bibleftmargin  % and this is apparently not refefined each time
  \renewcommand{\bibliographytypesize}{\footnotesize}}{}

}% end of jou mode (journal format)

%%%%%%%%%%%%%%%%%%
%                                                %
% HRI FORMAT                         %
%                                                %
%%%%%%%%%%%%%%%%%%
\@ifundefined{def@HRI}{}{%    % Mimics doc mode unless noted otherwise by MAG tag
\renewcommand\sfdefault{phv}  % MAG August 2010.  Changes all sf fonts to helvetica.  


%========== Sectioning, from theapa.sty ===============

% MAG.  Put a period after the fist section only, not after subsections.
% Thanks to http://www.latex-community.org/forum/viewtopic.php?f=47&t=7373
  \renewcommand\@seccntformat[1]{%
    \@ifundefined{#1@cntformat}%
    {\csname the#1\endcsname\quad}%
    {\csname #1@cntformat\endcsname}}
  \newcommand\section@cntformat{\large\bf{\thesection.\quad}}  % MAG Oct 2010, made the number large and bold

% MAG 3 August 2010.  Changed to traditional numbering on sections for the final manuscript copy, in accordance to HRI Journal Guidelines
% See http://help-csli.stanford.edu/tex/latex-sections.shtml

%\def\levelone#1{\apa@startsection%
%    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
%    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
%     \MakeUppercase{\expandafter{\large #1}}}}    % <- \bf  % thp 17Aug08
%\def\leveltwo#1{\apa@startsection%
%    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
%    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
%     {\large #1}}}                           % <- \bf
%\def\levelthree#1{\apa@startsection%
%    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
%    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
%    {\large\em #1}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}. \hskip .5em plus 1pt minus .5pt}} %% added space and moved skip inside -- thp 081113

%\def\levelone#1{\@startsection{section}{1}{\z@}{-10pt plus -4pt minus -2pt}{4pt}{\helvetica}{\MakeUppercase{#1}}}  % MAG: Skip values from acmtrans2m.cls
\def\levelone#1{\@startsection{section}{1}{\z@}{-10pt plus -4pt minus -2pt}{4pt}{\helvetica}{\large\bf{#1}}}  % MAG: Oct 2010 -- replace \makeuppercase with \Large
\def\leveltwo#1{\@startsection{subsection}{2}{\z@}{-8pt plus -2pt minus -1pt}{4pt}{}{#1}}  % MAG: 
\def\levelthree#1{\@startsection{subsubsection}{3}{\z@}{6pt plus 1pt}{-5pt}{\it}{#1}}
% MAG: Used for unnumbered sections (note the level*none*) such as the references.
%\def\levelnone#1{\apa@startsection%
%    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
%    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
%     \MakeUppercase{\expandafter{\large #1}}}}    % <- \bf  % thp 17Aug08
\def\levelnone#1{\@startsection{section}{4}{\z@}{-10pt plus -4pt minus -2pt}{4pt}{\helvetica}{\large\bf{#1}}}  % MAG: Oct 2010 -- replaced centered, all caps to left, bold.
% Note the implicit assumption that level 4 uses unindented font followed by a carriage return


%\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{\protect\small #1}}}  % MAG  \small --> \scriptsize
%\def\leftheader#1{\def\r@headl{\protect\MakeUppercase{\protect\small #1}}}     % MAG  \small --> \scriptsize
\def\rightheader#1{\def\r@headr{{\protect\small #1}}}  % MAG  \small --> \scriptsize
\def\leftheader#1{\def\r@headl{{\protect\small #1}}}     % MAG  \small --> \scriptsize
\def\shorttitle#1{\def\s@title{#1}}

 \@ifundefined{r@headr}{\typeout{Using title for running head} 
                        \def\r@headr{\protect\MakeUppercase{\@title}}
                        \markright{\rm \@title \protect\\ \thepage}} {}
 \@ifundefined{r@headl}{\let\r@headl\r@headr}{}
 \@ifundefined{s@title}{\let\s@title\r@headr}{}

% MAG: August 2010.
% Thanks to the pattern in acmtrans2m.cls and to http://tug.ctan.org/tex-archive/macros/latex/contrib/fancyhdr/fancyhdr.pdf
% Format of headers and footers for 2nd through last page.
\def\ps@myheadings{
 \let\@mkboth\@gobbletwo
 %\def\@oddhead{\hbox{}\rightmark\hfil\hspace{0.1in}\thepage} %% removed rm - thp 020227
 \def\@oddhead{\parbox{\textwidth}{\centering \leftmark, \rightmark}} % MAG Oct 2010, center with name and author
 %\def\@oddfoot{\hbox{}\hfill\footnotesize\@runningfoot}  % Commented out MAG Oct 2010
 %\def\@evenhead{\hbox{}\thepage\hfil\hspace{0.1in}\leftmark}
 \def\@evenhead{\parbox{\textwidth}{\centering \leftmark, \rightmark}} % MAG Oct 2010, center with name and author
 %\def\@evenfoot{\footnotesize\@runningfoot\hfill\hbox{}} % Commented out MAG Oct 2010
 \def\sectionmark##1{}
 \def\subsectionmark##1{}
}
%\def\@runningfoot{Journal of Human-Robot Interaction, Vol.\ 1, No.\ 1, 2010.} % Commented out MAG Oct 2010
\def\@firstfoot{\ \ \ \ Authors retain copyright and grant the Journal of Human-Robot Interaction right of first publication with the work simultaneously licensed under a Creative Commons Attribution License that allows others to share the work with an acknowledgement of the work's authorship and initial publication in this journal.
\newline
\newline
Journal of Human-Robot Interaction, Vol.\ 1, No.\ 1, 2012, Pages 78-95. DOI 10.5898/JHRI.1.1.Tanaka}

\pagestyle{myheadings}

%========== End of code from theapa.sty ===============

\def\maketitle{

 \global\@topnum\z@  % to prevent tables before the title   %% Erik Meijer, 2006/01/03 
 %\@ifundefined{@acks}{% if there acknowledgements they make up a "float" on the 1st page
 {  % MAG: Acknowledgements are not put as a footnote on the first page.  Rather, they are specified at the end of the paper.  Feb 2011.
 \global\@botnum\z@}{% to prevent tables on the first page  %% Erik Meijer, 2006/01/03 
 \global\@botnum\@ne}% to prevent tables below the footnote -- thp 2006/01/10 
 \check@author
 \@ifundefined{r@headr}{\typeout{Using title for running head} 
                        \def\r@headr{\protect\MakeUppercase{\@title}}
                        \markright{\rm \@title \protect\\ \thepage}} {}
 \@ifundefined{r@headl}{\let\r@headl\r@headr}{}
 \@ifundefined{s@title}{\let\s@title\r@headr}{}
  \sloppy 

  %\noindent{\Large \sf \@title}\\ % Mike Goodrich, \sf
  %\noindent{\LARGE \@title}\\ % Mike Goodrich, default font, not \sf
    \hspace*{-.3in}\begin{tabular}{ll}
    \parbox{.1in}{\includegraphics[width=0.03\textwidth, keepaspectratio=true]{JHRILogo}}
 & \parbox{5.0in}{\LARGE \@title} \end{tabular}\\ % Mike Goodrich, default font, not \sf

  \vspace{0.5\baselineskip}

% MAG: Oct 2010, removed all \MakeUppercase commands from authors

  \@ifundefined{@authorTwo}{
% one author-affiliation
  {  \large
%    \noindent{\MakeUppercase{\@author}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@author}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
     \noindent{\@affil} \\ 

    } 
  }  
  {
  \@ifundefined{@authorThree}{
% two authors-affiliations
 {  \large
    %\noindent{\MakeUppercase{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilOne} \vspace{0.2\baselineskip} \\
    \noindent{and} \vspace{0.3\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilTwo} 
  }
}
{
  \@ifundefined{@authorFour}{
 % three authors-affiliations
 {   \large
    %\noindent{\MakeUppercase{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilOne} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilTwo} \vspace{0.2\baselineskip} \\
    \noindent{and} \vspace{0.3\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilThree} 
  }
}
{
  \@ifundefined{@authorFive}{ %% 2006/01/05 added as contributed by Aaron Geller
% four authors-affiliations
 {   \large
    %\noindent{\MakeUppercase{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilOne} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilTwo} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilThree} \vspace{0.2\baselineskip} \\
    \noindent{and} \vspace{0.3\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilFour} 
  }
}{  %%% 2006/01/05 beginning of Aaron Geller contribution
  \@ifundefined{@authorSix}{ %% -- thp 2006/01/05
% five authors-affiliations
 {   \large
%    \noindent{\MakeUppercase{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilOne} \vspace{0.2\baselineskip} \\
%    \noindent{\MakeUppercase{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilTwo} \vspace{0.2\baselineskip} \\
%    \noindent{\MakeUppercase{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilThree} \vspace{0.2\baselineskip} \\
%    \noindent{\MakeUppercase{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilFour} \vspace{0.2\baselineskip} \\
    \noindent{and} \vspace{0.3\baselineskip} \\
%    \noindent{\MakeUppercase{\@authorFive}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorFive}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilFive} 
  }
}{  %%% 2006/01/05 end of Aaron Geller contribution 
% six authors-affiliations
%% --- thp 2006/01/05 beginning of six-author display
 {   \large
    %\noindent{\MakeUppercase{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorOne}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilOne} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorTwo}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilTwo} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorThree}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilThree} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorFour}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilFour} \vspace{0.2\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorFive}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorFive}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilFive} \vspace{0.2\baselineskip} \\
    \noindent{and} \vspace{0.3\baselineskip} \\
    %\noindent{\MakeUppercase{\@authorSix}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\Large{\@authorSix}}\vspace{0.1\baselineskip}\\ % Mike Goodrich,
    \noindent{\@affilSix} 
  }
}
%% --- thp 2006/01/05 end of six-author display
}}}}
%
% Add some space between the end of the authors and the horizontal line that offsets the abstract.
  \@ifundefined{@note}
   {\vspace*{\baselineskip} }
   {\@note\vspace{0.2in}}
   

 \hrule % Mike Goodrich. Offset abstract at top and bottom by a horizontal line.

% Mike Goodrich, August 3, 2010
% Add special fields required for HRI Journal to document mode

 \@ifundefined{@abstract}{}{%
   % {\bf\abstractname}\vspace{0.1in}% changed from 'Abstract' 10/00  % Mike Goodrich Commented out abstract name here.
	\vspace{0.1in}  % Mike Goodrich

   \noindent\parbox{5.5in}{\@abstract}\vspace{0.5\baselineskip}
  }
  
  \@ifundefined{@keywords}{}{%
  \noindent\parbox{5.5in}{Keywords: \@keywords}\vspace{0.1\baselineskip}
   }

 \hrule % Mike Goodrich. Offset abstract at top and bottom by a horizontal line.

 %  \end{center} % Mike Goodrich 
 
 \pagenumbering{arabic}
 \thispagestyle{empty}
% \@ifundefined{@acks}%  % If there is no acknowledgements defined (there must not be!), then create a figure at the bottom of the page with the predefined copyright information.
  {\begin{figure}[b]
   \parbox{\textwidth}{ \setlength{\parindent}{0.2in}
   \noindent \makebox[\linewidth]{\vrule height0.125pt width\linewidth}

  % MAG Feb 2011: Hardcoded footer with acknowledgements  
  % MAG Aug 2011: Removed AAAI Copyright
  \def\@ccoppy{}%Copyright \copyright 2011, Association for the Advancement of Artificial Intelligence. All rights reserved. }  
   %\vspace*{0.02in}
   {\footnotesize
   \indent{\@ccoppy} %\vspace{.15\baselineskip} 
 
   \noindent{\@firstfoot}  % This is where the Journal name, volume, and issue is inserted.
   }}
   \end{figure}}
 %\markboth{\hfill \r@headl \hfill}{\hfill \r@headr \hfill}
 %\markboth{\sf \r@headl}{\sf \r@headr}  % Mike Goodrich, \sf, no hfill
 \markboth{\r@headl}{\r@headr}  % Mike Goodrich, no \hfill
 \let\tabular\apa@doc@tabular% -- thp 2006/01/02
 \let\endtabular\apa@doc@endtabular% -- thp 2006/01/03
 %\noindent
}

\HRIHeadingStyle  % MAG: \ThreeLevelHeading --> \HRIHeadingStyle
%\def\refname{References}
% MAG: Margins for HRI Journal.
% Thanks to http://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength{\voffset}{-1in}  % Distance from top of page to printable space.  -1in means align right at top of page.
\setlength{\hoffset}{-1in}
\setlength{\topmargin}{1in}  % 1 inches means that the header starts exactly 1 inch from the top of the page.
\setlength{\headheight}{.0in}%{12pt}  0 inches makes the top of the header right at the 1 inch margin mark.
\setlength{\headsep}{.5in}%{16pt}
\setlength{\footskip}{.5in}%{15pt}
\setlength{\oddsidemargin}{1.5in} % Changed by Mike Goodrich 1.75in-->1.5in
\setlength{\evensidemargin}{1.5in} % Changed by Mike Goodrich 1.75in-->1.5in
\setlength{\textwidth}{5.5in}       % Change by Mike Goodrich  6in-->5.5in
\setlength{\textheight}{8in}      % Change by Mike Goodrich  8in-->5in
\setcounter{secnumdepth}{3}  % Changed by Mike Goodrich, 3 August, 2010, to conform to HRI Journal numbering.  Was set to 0.  Only show numbers for first three levels.
\flushbottom

\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.6}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.7}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.8}
\def\dblfloatpagefraction{.8}
\def\dbltextfloatsep{0.8\textfloatsep}

\def\helvetica{\relax}
%\def\timesroman{\relax}%    Commented out all \timesroman -- thp 2005/07/23
\def\centeredcaption#1{\caption}

\long\def\@makecaption#1#2{
 \let\BBAB\table@BBAB% thp 2005/07/23
 \vskip 10pt 
 \setbox\@tempboxa\hbox{#1 #2}
 \ifdim \wd\@tempboxa >\hsize #1 #2\par \else \hbox
to\hsize{\hfil\box\@tempboxa\hfil} 
 \fi 
 \let\BBAB\normal@BBAB% thp 2005/07/23
 \vskip 4pt}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\def\fnum@figure{\small {\em\figurename\ {\thefigure}}.\hspace{0.07in}}
\long\def\fnum@table{\small\tablename\ {\thetable}:}

\@ifundefined{def@noapacite}{% -- Philip Kime 2008/12/03
  % Removed defs as per the instructions of Erik Meijer -- thp 2005/07/23
  \renewcommand{\bibliographytypesize}{\small}}{}

}% end of HRI mode (HRI journal format)

%%%%%%%%%%%%%%%%%%
%                %
% REGULAR FORMAT %
%                %
%%%%%%%%%%%%%%%%%%

\@ifundefined{def@doc}{}{%

%========== Sectioning, from theapa.sty ===============

\def\levelone#1{\apa@startsection%
    {\z@}{\b@level@one@skip}{\e@level@one@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     \MakeUppercase{\expandafter{\large #1}}}}    % <- \bf  % thp 17Aug08
\def\leveltwo#1{\apa@startsection%
    {\z@}{\b@level@two@skip}{\e@level@two@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
     {\large #1}}}                           % <- \bf
\def\levelthree#1{\apa@startsection%
    {\z@}{\b@level@three@skip}{\e@level@three@skip}%
    {\leftskip4em plus 1fill\rightskip\leftskip\parindent\z@\relax%
    {\large\em #1}}}
\def\levelfour#1{\apa@startsection%
    {\z@}{\b@level@four@skip}{\e@level@four@skip}{{\em #1}}}
\def\levelfive#1{\apa@startsection%
    {\parindent}{\b@level@five@skip}{\e@level@five@skip}{{\em #1}. \hskip .5em plus 1pt minus .5pt}} %% added space and moved skip inside -- thp 081113

\def\rightheader#1{\def\r@headr{\protect\MakeUppercase{\protect\small #1}}}
\def\leftheader#1{\def\r@headl{\protect\MakeUppercase{\protect\small #1}}}
\def\shorttitle#1{\def\s@title{#1}}
\pagestyle{myheadings}

%========== End of code from theapa.sty ===============

\def\maketitle{
 \global\@topnum\z@  % to prevent tables before the title   %% Erik Meijer, 2006/01/03 
 \@ifundefined{@acks}{% if there acknowledgements they make up a "float" on the 1st page
 \global\@botnum\z@}{% to prevent tables on the first page  %% Erik Meijer, 2006/01/03 
 \global\@botnum\@ne}% to prevent tables below the footnote -- thp 2006/01/10 
 \check@author
 \@ifundefined{r@headr}{\typeout{Using title for running head} 
                        \def\r@headr{\protect\MakeUppercase{\@title}}
                        \markright{\rm \@title \protect\\ \thepage}} {}
 \@ifundefined{r@headl}{\let\r@headl\r@headr}{}
 \@ifundefined{s@title}{\let\s@title\r@headr}{}
  \sloppy 
  \setlength{\parindent}{0.4in}
  \begin{center}
   \@ifundefined{@journal}{}{%
    \@ifundefined{@vvolume}{\def\@vvolume{}}{}%
    \@ifundefined{@copnum}{\def\@copnum{}}{}%
    \@ifundefined{@ccoppy}{\def\@ccoppy{}}{}%
    {\scriptsize{\@journal}}\hspace{\fill}{\scriptsize{\@ccoppy}}\vspace{-0.3\baselineskip}\\
    {\scriptsize{\@vvolume}}\hspace{\fill}{\scriptsize{\@copnum}}\vspace{0.1in}\\
   }
  \vspace*{0.3in}

  {\LARGE \@title}\\
  
  \vspace{0.3in}

  \@ifundefined{@authorTwo}{
% one author-affiliation
  {\Large \@author} \\

  \@affil \vspace{0.1in} \\ }{
  \@ifundefined{@authorThree}{
% two authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ }{
  \@ifundefined{@authorFour}{
% three authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ }{
  \@ifundefined{@authorFive}{ %% 2006/01/05 added as contributed by Aaron Geller
% four authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ 
  {\Large \@authorFour}\\

  \@affilFour \vspace{0.1in} \\ }{  %%% 2006/01/05 beginning of Aaron Geller contribution
  \@ifundefined{@authorSix}{ %% -- thp 2006/01/05
% five authors-affiliations
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ 
  {\Large \@authorFour}\\

  \@affilFour \vspace{0.1in} \\
  {\Large \@authorFive}\\

  \@affilFive \vspace{0.1in} \\ }{  %%% 2006/01/05 end of Aaron Geller contribution
% six authors-affiliations
%% --- thp 2006/01/05 beginning of six-author display
  {\Large \@authorOne} \\

  \@affilOne \vspace{0.1in} \\
  {\Large \@authorTwo}\\

  \@affilTwo \vspace{0.1in} \\ 
  {\Large \@authorThree}\\

  \@affilThree \vspace{0.1in} \\ 
  {\Large \@authorFour}\\

  \@affilFour \vspace{0.1in} \\
  {\Large \@authorFive}\\

  \@affilFive \vspace{0.1in} \\
  {\Large \@authorSix}\\

  \@affilSix \vspace{0.1in} \\ }
%% --- thp 2006/01/05 end of six-author display
}}}}
%
  \@ifundefined{@note}
   {\vspace*{\baselineskip} }
   {\@note\vspace{0.2in}}

  \@ifundefined{@abstract}{}{%
   {\bf\abstractname}\vspace{0.1in}% changed from 'Abstract' 10/00

   \parbox{5in}{\@abstract}\vspace{0.25in}
  }
  \end{center}
 \pagenumbering{arabic}
 \thispagestyle{empty}
 \@ifundefined{@acks}
  {}
  {\begin{figure}[b]
   \parbox{\textwidth}{ \setlength{\parindent}{0.2in}
   \noindent \makebox[\linewidth]{\vrule height0.125pt width\linewidth}

   \vspace*{0.05in}
   {\footnotesize
   \indent \@acks

   }}
   \end{figure}}
 \markboth{\hfill \r@headl \hfill}{\hfill \r@headr \hfill}
 \let\tabular\apa@doc@tabular% -- thp 2006/01/02
 \let\endtabular\apa@doc@endtabular% -- thp 2006/01/03
 \noindent
}

\ThreeLevelHeading
%\def\refname{References}
\setlength{\topmargin}{-0.25in}
\setlength{\oddsidemargin}{0.25in}
\setlength{\evensidemargin}{0.25in}
\setlength{\textwidth}{6in}
\setlength{\textheight}{8.5in}
\setcounter{secnumdepth}{0}
\flushbottom

\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.6}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.7}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.8}
\def\dblfloatpagefraction{.8}
\def\dbltextfloatsep{0.8\textfloatsep}

\def\helvetica{\relax}
%\def\timesroman{\relax}%    Commented out all \timesroman -- thp 2005/07/23
\def\centeredcaption#1{\caption}

\long\def\@makecaption#1#2{
 \let\BBAB\table@BBAB% thp 2005/07/23
 \vskip 10pt 
 \setbox\@tempboxa\hbox{#1 #2}
 \ifdim \wd\@tempboxa >\hsize #1 #2\par \else \hbox
to\hsize{\hfil\box\@tempboxa\hfil} 
 \fi 
 \let\BBAB\normal@BBAB% thp 2005/07/23
 \vskip 4pt}

\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname 
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\def\fnum@figure{\small {\em\figurename\ {\thefigure}}.\hspace{0.07in}}
\long\def\fnum@table{\small\tablename\ {\thetable}:}

\@ifundefined{def@noapacite}{% -- Philip Kime 2008/12/03
  % Removed defs as per the instructions of Erik Meijer -- thp 2005/07/23
  \renewcommand{\bibliographytypesize}{\small}}{}

}% end of doc mode (regular LaTeX format)

%---------- end of mode specific definitions -----------


%=======================================================
%       Some final definitions for all modes
%=======================================================

\let\ignore\@gobble
\let\oneLevelHeading=\OneLevelHeading
\let\twoLevelHeading=\TwoLevelHeading
\let\threeLevelHeading=\ThreeLevelHeading
\let\fourLevelHeading=\FourLevelHeading
\let\fiveLevelHeading=\FiveLevelHeading
\def\HeadingLevels#1{\csname #1LevelHeading\endcsname} % fixed Jan 5 99
\def\headinglevels#1{\csname #1LevelHeading\endcsname} % fixed Jan 5 99

\@ifundefined{def@noapacite}{% -- Philip Kime 2008/12/03
  \bibliographystyle{apacite}
  %
  % Thanks to Donald Arsenau for the right way to ignore \bibliographystyle
  %
  \def\bibliographystyle#1{\ClassWarning{apa}{\string\bibliographystyle\space command ignored}}}{}
