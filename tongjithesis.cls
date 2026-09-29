\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[2026/09/18 Tongji University thesis template]

\LoadClass[UTF8,zihao=-4,fontset=none,openright]{ctexbook}

% Word settings: margins 2.54 cm (top/bottom), 3.17 cm (left/right).
% The offsets place the top of the visible header text 2.00 cm from the physical
% top edge and the bottom of the footer glyphs 1.50 cm from the bottom edge.
% headheight/headsep also fix the header rule (fancyhdr \headrule) at the
% position measured in the reference (glyph rows 71.28-71.88 pt).
\RequirePackage[a4paper,left=3.17cm,right=3.17cm,top=2.54cm,bottom=2.54cm,
  headheight=16pt,headsep=0.72pt,footskip=0.96cm]{geometry}
% Chapter-level material always starts on a recto (odd) page; the blank verso
% inserted by \cleardoublepage must carry no header/footer.
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}\thispagestyle{empty}\newpage \if@twocolumn\hbox{}\newpage\fi\fi\fi}

\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{tabularray}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}
\RequirePackage[backend=biber,style=gb7714-2015,sorting=none]{biblatex}

% Chinese fonts are intentionally loaded from repository-relative file paths.
% SimSun has no bold face; AutoFakeBold emulates Word's bolded SimSun everywhere.
\setCJKmainfont[Path=fonts/,AutoFakeBold=2.5]{simsun.ttf}
\setCJKsansfont[Path=fonts/,AutoFakeBold=2.5]{simhei.ttf}
\setCJKmonofont[Path=fonts/]{simfang.ttf}
\setCJKfamilyfont{song}[Path=fonts/,AutoFakeBold=2.5]{simsun.ttf}
\setCJKfamilyfont{hei}[Path=fonts/,AutoFakeBold=2.5]{simhei.ttf}
\setCJKfamilyfont{fang}[Path=fonts/,AutoFakeBold=2.5]{simfang.ttf}
\setCJKfamilyfont{li}[Path=fonts/,AutoFakeBold=4]{lishu.ttf}
\newcommand{\songti}{\CJKfamily{song}}
\newcommand{\heiti}{\CJKfamily{hei}}
\newcommand{\fangsong}{\CJKfamily{fang}}
\newcommand{\lishu}{\CJKfamily{li}}

\setmainfont{Times New Roman}
\setsansfont{Arial}
\newfontfamily\arialfont{Arial}
% SimHei for Latin digits/letters inside headings, matching Word heading fonts.
\newfontfamily\heilatin[Path=fonts/,AutoFakeBold=2.5]{simhei.ttf}

\hypersetup{hidelinks,unicode=true,bookmarksnumbered=true,hypertexnames=false}
% PDF document metadata mirrors the thesis metadata once the preamble ran.
\AtBeginDocument{%
  \hypersetup{
    pdftitle=\tongji@title,
    pdfauthor=\tongji@author,
    pdfsubject={同济大学博士学位论文（\tongji@degreetype）}
  }
}
\graphicspath{{figures/}{assets/}}
\addbibresource{references.bib}

% Normal text: small size 4, fixed 20 pt leading and two-character indent.
\AtBeginDocument{%
  \linespread{1}\songti\zihao{-4}\fontsize{12bp}{20bp}\selectfont
  \setlength{\parindent}{2em}%
  \setlength{\parskip}{0pt}%
  \setlength{\abovedisplayskip}{6bp}%
  \setlength{\belowdisplayskip}{6bp}%
}

\ctexset{
  chapter={
    name={第,章},
    number=\arabic{chapter},
    format=\centering\linespread{1}\heiti\heilatin\bfseries\zihao{3}%
      \CJKsetecglue{\hskip 0.27em plus 0.08em minus 0.08em},
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\relax,
    % Calibrated against the reference: title glyph top 103.6 pt, title to
    % the following first section heading 39.97 pt, both measured in the sample.
    % The page-top \topskip (see \thesispagetopskip) supplies part of the
    % 24 pt Word preskip, so the remainder is preset here.
    beforeskip=-0.63pt,
    afterskip=37.1bp,
    aftername=\enspace,
    pagestyle=tongjimain
  },
  section={
    format=\raggedright\heiti\heilatin\zihao{-3},
    % Reference: body-to-section ink gap 34.28 pt, section-to-body 19.72 pt.
    beforeskip=30.9bp,
    afterskip=12.1bp,
    aftername=\enspace
  },
  subsection={
    format=\raggedright\heiti\heilatin\zihao{4},
    % Reference: section-to-subsection ink gap 28.63 pt, subsection-to-body 25.17 pt.
    beforeskip=26bp,
    afterskip=17.5bp,
    aftername=\enspace
  }
}

% Word adds the space after a heading and before the next heading; LaTeX
% instead suppresses the preskip of a heading that directly follows another
% (\@nobreak). Reset the flag for subsections so their preskip participates
% in \addvspace and adjacent section/subsection headings match the sample.
\let\tongji@origsubsection\subsection
\renewcommand{\subsection}{\@nobreakfalse\tongji@origsubsection}

% Page-top "paragraph before" space of the body text (0.7 line), used both by
% \thesispagetopskip and above floats that drift to the top of a page: Word
% keeps that space for whatever starts a page, so a figure or table at the top
% of a page stays as far from the header rule as the first line of body text.
\newlength{\tongji@bodytopsep}\setlength{\tongji@bodytopsep}{14.88pt}
\patchcmd{\@cflt}{\unvbox\@tempboxa}{\vskip\tongji@bodytopsep\unvbox\@tempboxa}%
  {}{\PackageWarning{tongjithesis}{\string\@cflt\space could not be patched}}

% Header line: 5th-size SimSun, centred, with the sample's rule drawn by
% fancyhdr's \headrule (position set by \headsep above).  The reference keeps
% the glyph top 2.00 cm from the paper edge; the raisebox restores that offset
% after the header box was shortened to pull the rule down to the sample's rule.
\newcommand{\tongji@head}[1]{%
  \raisebox{1.33pt}{\songti\zihao{5}\fontsize{10.5bp}{12bp}\selectfont#1}%
}
\fancypagestyle{tongjifront}{
  \fancyhf{}
  \fancyhead[C]{\tongji@head{\leftmark}}
  \fancyfoot[C]{\rmfamily\zihao{5}\Roman{page}}
  \renewcommand{\headrulewidth}{0.75bp}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{tongjimain}{
  \fancyhf{}
  \fancyhead[C]{\tongji@head{\leftmark}}
  \fancyfoot[C]{\rmfamily\zihao{5}\arabic{page}}
  \renewcommand{\headrulewidth}{0.75bp}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{tongjideclaration}{
  \fancyhf{}
  \fancyfoot[C]{\rmfamily\zihao{5}\arabic{page}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{tongjimain}
\renewcommand{\chaptermark}[1]{\markboth{\ifnum\value{chapter}>0 第\thechapter\ 章\quad\fi#1}{}}

\captionsetup[figure]{font={small},labelfont=normalfont,labelsep=quad,
  justification=centering,singlelinecheck=true,skip=6bp}
\captionsetup[table]{font={small},labelfont=normalfont,labelsep=quad,
  justification=centering,singlelinecheck=true,skip=6bp,position=top}
% Sub-captions follow the same look: "(a)  子图题".
\captionsetup[sub]{font={small},labelfont=normalfont,labelsep=quad,
  justification=centering,singlelinecheck=false,skip=6bp}
\AtEndEnvironment{figure}{\vspace{6bp}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}

\setcounter{tocdepth}{2}
\renewcommand{\cfttoctitlefont}{\hfill\heiti\bfseries\zihao{3}}
\renewcommand{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{1.18pt}
\setlength{\cftaftertoctitleskip}{25.5bp}
\renewcommand{\cftchapfont}{\songti\zihao{-4}}
\renewcommand{\cftsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}
\renewcommand{\cftchappagefont}{\songti\zihao{-4}}
\renewcommand{\cftsecpagefont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\songti\zihao{-4}}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftsecindent}{1em}
\setlength{\cftsubsecindent}{2em}
% Leader dot pitch 6.0 pt as in the reference (default 4.5 mu gives 9.0 pt).
\renewcommand{\cftdotsep}{2.25}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\contentsname}{目录}

\makeatletter
\newcommand{\tongji@def}[2]{\expandafter\def\csname tongji@#1\endcsname{#2}}
\newcommand{\thesistitle}[1]{\tongji@def{title}{#1}}
\newcommand{\thesistitleen}[1]{\tongji@def{titleen}{#1}}
\newcommand{\thesisauthor}[1]{\tongji@def{author}{#1}}
\newcommand{\studentid}[1]{\tongji@def{studentid}{#1}}
\newcommand{\school}[1]{\tongji@def{school}{#1}}
\newcommand{\category}[1]{\tongji@def{category}{#1}}
\newcommand{\discipline}[1]{\tongji@def{discipline}{#1}}
\newcommand{\subdiscipline}[1]{\tongji@def{subdiscipline}{#1}}
\newcommand{\researchfield}[1]{\tongji@def{researchfield}{#1}}
\newcommand{\supervisor}[1]{\tongji@def{supervisor}{#1}}
\newcommand{\associatesupervisor}[1]{\tongji@def{associate}{#1}}
\newcommand{\jointinstitution}[1]{\tongji@def{joint}{#1}}
\newcommand{\degreecategory}[1]{\tongji@def{degreetype}{#1}}
\newcommand{\coverdate}[1]{\tongji@def{date}{#1}}
\newcommand{\coverdateen}[1]{\tongji@def{dateen}{#1}}
\newcommand{\degreeen}[1]{\tongji@def{degreeen}{#1}}
\newcommand{\spinetitle}[1]{\tongji@def{spinetitle}{#1}}
\newcommand{\thesisauthoren}[1]{\tongji@def{authoren}{#1}}
\newcommand{\schoolen}[1]{\tongji@def{schoolen}{#1}}
\newcommand{\categoryen}[1]{\tongji@def{categoryen}{#1}}
\newcommand{\disciplineen}[1]{\tongji@def{disciplineen}{#1}}
\newcommand{\subdisciplineen}[1]{\tongji@def{subdisciplineen}{#1}}
\newcommand{\researchfielden}[1]{\tongji@def{researchfielden}{#1}}
\newcommand{\supervisoren}[1]{\tongji@def{supervisoren}{#1}}
\newcommand{\associatesupervisoren}[1]{\tongji@def{associateen}{#1}}
\newcommand{\jointinstitutionen}[1]{\tongji@def{jointen}{#1}}

\def\tongji@title{中文论文题目}
\def\tongji@titleen{English Thesis Title}
\def\tongji@author{姓名}
\def\tongji@studentid{学号}
\def\tongji@school{学院}
\def\tongji@category{工学}
\def\tongji@discipline{一级学科}
\def\tongji@subdiscipline{二级学科}
\def\tongji@researchfield{研究方向}
\def\tongji@supervisor{指导教师}
\def\tongji@associate{}
\def\tongji@joint{}
\def\tongji@degreetype{学术学位}
\def\tongji@date{二〇二六年五月}
\def\tongji@dateen{May 2026}
\def\tongji@degreeen{Engineering}
\def\tongji@spinetitle{中文论文题目}
\def\tongji@authoren{San ZHANG}
\def\tongji@schoolen{College of Civil Engineering}
\def\tongji@categoryen{Engineering}
\def\tongji@disciplineen{Civil Engineering}
\def\tongji@subdisciplineen{Structural Engineering}
\def\tongji@researchfielden{Engineering Structural Reliability}
\def\tongji@supervisoren{Prof. Si LI}
\def\tongji@associateen{}
\def\tongji@jointen{}

% Cover form: labels are spread to a 4-character field so every colon aligns,
% values start exactly after the full-width colon, and rows use the 31.2 bp
% pitch measured from the reference cover.
\newcommand{\tongji@coverrow}[2]{%
  \noindent\hspace*{88.22pt}\makebox[4em][s]{#1}\makebox[1em][l]{：}#2\par
}
\newcommand{\tongji@coverrowL}[2]{%
  \noindent\hspace*{88.22pt}\makebox[6em][l]{#1}\makebox[1em][l]{：}#2\par
}
\newcommand{\makechinesecover}{
  \clearpage\thispagestyle{empty}
  \vspace*{0.25cm}
  \begin{center}
    \includegraphics[width=10cm,height=2.6cm]{tongji-logo-000.png}
    \vspace{0.376cm}

    {\lishu\bfseries\zihao{2} 博士学位论文\par}
    \vspace{0.664cm}
    {\lishu\bfseries\zihao{3}（\tongji@degreetype）\par}
    \vspace{1.6cm}
    {\heiti\bfseries\zihao{2}\tongji@title\par}
  \end{center}
  \vspace{3.035cm}
  {\linespread{1}\fangsong\zihao{3}\fontsize{16bp}{31.2bp}\selectfont
    \tongji@coverrow{姓\hfill 名}{\tongji@author}
    \tongji@coverrow{学\hfill 号}{\tongji@studentid}
    \tongji@coverrow{学\hfill 院}{\tongji@school}
    \tongji@coverrow{学科门类}{\tongji@category}
    \tongji@coverrow{一级学科}{\tongji@discipline}
    \tongji@coverrow{二级学科}{\tongji@subdiscipline}
    \tongji@coverrow{研究方向}{\tongji@researchfield}
    \tongji@coverrow{指导教师}{\tongji@supervisor}
    \tongji@coverrowL{联合培养单位}{\tongji@joint}
    \par
  }
  \vfill
  \begin{center}{\songti\zihao{3}\tongji@date\par}\end{center}
  \vspace{-10.75pt}
  \cleardoublepage
}

\newcommand{\makeenglishcover}{
  \thispagestyle{empty}
  \vspace*{-0.7cm}
  \begin{center}
    \includegraphics[width=10cm,height=2.6cm]{tongji-logo-000.png}
    \vspace{0.03cm}

    {\rmfamily\fontsize{14bp}{30bp}\linespread{1}\selectfont
      A dissertation submitted to\par
      Tongji University in partial fulfillment of the requirements for\par
      the degree of Doctor of \tongji@degreeen\par}
    \vspace{1.55cm}
    {\arialfont\bfseries\zihao{-2}\tongji@titleen\par}
  \end{center}
  \vspace{2.1cm}
  {\rmfamily\fontsize{16bp}{31bp}\linespread{1}\selectfont
    \parindent=0pt\leftskip=83.66pt
    Candidate: \tongji@authoren\par
    Student Number: \tongji@studentid\par
    School/Department: \tongji@schoolen\par
    Categories: \tongji@categoryen\par
    First-level Discipline/Degree: \tongji@disciplineen\par
    Second-level Discipline/Degree's Field: \tongji@subdisciplineen\par
    Research Fields: \tongji@researchfielden\par
    Supervisor: \tongji@supervisoren\par
    Associate Supervisor: \tongji@associateen\par
    Joint Training Institution: \tongji@jointen\par
  }
  \vfill
  \begin{center}{\rmfamily\zihao{3}\tongji@dateen\par}\end{center}
  \vspace{0.1cm}
  \cleardoublepage
}

% A separate printable spine guide. The narrow parboxes keep Chinese glyphs upright.
\newcommand{\makespine}{
  \thispagestyle{empty}
  \vspace*{-1.3cm}
  \begin{center}
    \fbox{\begin{minipage}[t][23.1cm][t]{0.95cm}
      \centering\linespread{1}\fangsong\bfseries\zihao{4}\fontsize{14bp}{16bp}\selectfont
      \vspace*{3.7cm}
      \parbox{1em}{\centering\tongji@spinetitle}
      \vfill
      \parbox{1em}{\centering\tongji@author}
      \vfill
      \parbox{1em}{\centering 同济大学}
      \vspace*{3.8cm}
    \end{minipage}}
  \end{center}
  \clearpage
}

\newenvironment{cnabstract}[1]{
  \clearpage
  \markboth{摘要}{摘要}
  % The page-top \topskip also lifts this title, so its own skip is reduced.
  \begin{center}\vspace*{1.18pt}{\heiti\bfseries\zihao{3}摘要\par}\vspace{11bp}\end{center}
  \linespread{1}\songti\zihao{-4}\fontsize{12bp}{20bp}\selectfont
  \def\tongji@keywords{#1}\par\noindent\hspace*{2em}\ignorespaces
}{
  \par\vspace{15bp}\noindent\textbf{关键词：}\tongji@keywords
  \clearpage
}
\newenvironment{enabstract}[1]{
  \markboth{Abstract}{Abstract}
  \begin{center}\vspace*{1.18pt}{\arialfont\bfseries\zihao{3}ABSTRACT\par}\vspace{11bp}\end{center}
  \linespread{1}\rmfamily\zihao{-4}\fontsize{12bp}{20bp}\selectfont\setlength{\parindent}{2em}
  \def\tongji@keywords{#1}\par\noindent\hspace*{2em}\ignorespaces
}{
  \par\vspace{15bp}\noindent\textbf{Key Words: }\tongji@keywords
  \clearpage
}

\newcommand{\thesistableofcontents}{
  \markboth{目录}{目录}
  {\linespread{1}\fontsize{12bp}{18bp}\selectfont\tableofcontents\thispagestyle{tongjifront}}
  \clearpage
}
% Word gives the first body line on a page a "paragraph before" space of
% 0.7 line (fixed 20 pt leading -> 14 pt).  LaTeX discards inter-paragraph
% glue at the top of a page, so the page-top body spacing is carried by
% \topskip instead.  The reference renders the first body line 14.88 pt lower
% than \topskip=12pt would place it (first-line glyph top 89.0 pt in the sample);
% titles that start a page have their own preskip reduced by the same amount
% so every previously calibrated position is preserved.
\newcommand{\thesispagetopskip}{%
  \setlength{\topskip}{12pt}\addtolength{\topskip}{\tongji@bodytopsep}}
\newcommand{\thesisfrontmatter}{%
  \clearpage\thesispagetopskip\@mainmatterfalse\pagenumbering{Roman}\pagestyle{tongjifront}%
}
\newcommand{\thesismainmatter}{%
  \clearpage\@mainmattertrue\pagenumbering{arabic}\pagestyle{tongjimain}%
}

\newcommand{\specialchapter}[1]{
  \chapter*{#1}\addcontentsline{toc}{chapter}{#1}\markboth{#1}{#1}
}
\newenvironment{acknowledgements}{
  \specialchapter{致谢}\linespread{1}\fangsong\zihao{-4}\fontsize{12bp}{20bp}\selectfont
}{\par}
\newenvironment{thesiscv}{
  \ctexset{chapter={beforeskip=-17.9pt,afterskip=24bp}}
  \specialchapter{个人简历、在读期间发表的学术成果}
  \linespread{1}\songti\zihao{5}\fontsize{10.5bp}{16bp}\selectfont\setlength{\parindent}{0pt}
}{\par}

\newcommand{\makedeclarations}{
  \cleardoublepage\pagestyle{tongjideclaration}\thispagestyle{tongjideclaration}\markboth{}{}
  \begingroup\setlength{\topskip}{12pt}%
  \linespread{1}\songti\fontsize{14bp}{26bp}\selectfont
  \begin{center}{\heiti\bfseries\fontsize{18bp}{22bp}\selectfont 同济大学学位论文原创性声明\par}\end{center}
  \vspace{14bp}\noindent\hspace*{2em}%
  本人郑重声明：所呈交的学位论文《\tongji@title》，是本人在导师指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本学位论文的研究成果不包含任何他人创作的、已公开发表或者没有公开发表的作品的内容。对本论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。本学位论文原创性声明的法律责任由本人承担。

  \vspace{14bp}\hspace*{8em}\textbf{学位论文作者签名：}

  \vspace{8bp}\hspace*{13em}\textbf{日期：}\hspace{2em}年\hspace{2em}月\hspace{2em}日

  \vspace{10bp}\noindent\rule{\linewidth}{0.5bp}\vspace{10bp}
  \begin{center}{\heiti\bfseries\fontsize{18bp}{22bp}\selectfont 同济大学学位论文版权使用授权书\par}\end{center}
  \vspace{14bp}\noindent\hspace*{2em}%
  本人完全了解同济大学关于收集、保存、使用学位论文的规定，同意如下各项内容：按照学校要求提交学位论文的印刷本和电子版；学校有权保存论文的印刷本和电子版，并采用影印、缩印、扫描、数字化或其它手段保存论文；学校有权提供目录检索以及提供本论文全文或部分的阅览服务；学校有权按有关规定向国家有关部门或机构送交论文的复印件和电子版；允许论文被查阅和借阅。学校有权将本论文的全部或部分内容授权编入有关数据库出版传播。

  \vspace{10bp}\textbf{本学位论文属于（在以下方框内打“√”）：}

  $\square$ 保密，在\underline{\hspace{1.5cm}}年解密后适用本授权书。

  $\square$ 不保密。

  \vfill
  \noindent\textbf{学位论文作者签名：}\hfill\textbf{指导教师签名：}\hspace*{73.4pt}
  % \clearpage\thispagestyle{tongjideclaration}

  \noindent\textbf{日期：}\hspace{2em}年\hspace{2em}月\hspace{2em}日\hfill
  \textbf{日期：}\hspace{2em}年\hspace{2em}月\hspace{2em}日
  \endgroup
  \clearpage
}

\defbibheading{bibliography}[参考文献]{\specialchapter{#1}}
\AtBeginBibliography{%
  \linespread{1}\songti\zihao{5}\fontsize{10.5bp}{16bp}\selectfont
  \setlength{\bibhang}{2em}\setlength{\bibitemsep}{0pt}
}
\makeatother

\endinput
