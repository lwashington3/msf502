%! Class = msf502homework.cls
%! Author = Len Washington III
%! Date = 2/1/25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msf502homework}[Len Washington III's Document Class]

\LoadClass[12pt]{report}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family=msfhomework,
	prefix=msfhomework@
}

\DeclareStringOption{number}
\DeclareBoolOption[true]{answers}
\DeclareBoolOption[false]{corrections}
\DeclareStringOption[]{title}

\ProcessKeyvalOptions*

\renewcommand{\title}{MSF 502 - Homework \msfhomework@number\ifx\msfhomework@title\empty\else\ - \msfhomework@title\fi}

\RequirePackage[
	title={\title},
]{msf502}
\RequirePackage{makecell}
\usetikzlibrary{shapes.geometric}

\hypersetup{
	linkcolor=black
}

\renewcommand{\maketitle}{%
	\begin{center}\textbf{\title}\end{center}
	\vspace{0.5em}
}

\RequirePackage{enumitem}
\newlist{problems}{enumerate}{3}
\setlist[problems, 1]
{label=\textbf{\arabic{problemsi}.},
	leftmargin=15pt,
}

\RequirePackage{alphalph}
\RequirePackage{bookmark}
\newcommand*\makeAlph[1]{\alphalph{\the\numexpr\value{#1}+1}}
\newcommand*\makeRoman[1]{\romannumeral\the\numexpr\value{#1}+1}
%\newcommand*\makeRoman[1]{\lowercase\expandafter\@slowromancap\romannumeral\the\numexpr\value{#1}+1@}

\definecolor{problempink}{HTML}{ec008c}

\setlist[problems, 1]
{label=\textcolor{problempink}{\textbf{\arabic{chapter}-\arabic{problemsi}}},
	leftmargin=30pt,}

\setlist[problems, 2]
{label=\textbf{(\alph{problemsii})},
	leftmargin=30pt,}

\setlist[problems, 3]
{label=\textbf{(\roman{problemsiii})},
	leftmargin=35pt,}

\newcounter{problem}
\setcounter{problem}{1}
\newcommand{\problem}[1][prb:\the\numexpr\value{chapter}.\the\numexpr\value{section}.\number\value{problemsi}]{%
	\pdfbookmark[3] % Level
	{Problem \arabic{chapter}-\the\numexpr\value{problemsi}+1} % Text
	{#1}% Name/Label
	\item\label{#1}}

\newcommand{\subproblem}{%
	\pdfbookmark[4]% Level
	{Problem \arabic{chapter}-\the\numexpr\value{problemsi}\makeAlph{problemsii}}% Text
	{prb:\msfhomework@number.\number\value{problemsi}\makeAlph{problemsii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}}}

\newcommand{\subsubproblem}{%
	\pdfbookmark[5]% Level
	{Problem \the\numexpr\value{problemsi}\alph{problemsii}(\makeRoman{problemsiii})}% Text
	{prb:\msfhomework@number.\number\value{problemsi}\alph{problemsii}.\makeRoman{problemsiii}}% Name/Label
	\item\label{prb:\number\value{problemsi}\alph{problemsii}\roman{problemsiii}}}

\newcommand{\answerfile}{%
	\ifmsfhomework@corrections%
	homework\msfhomework@number_corrections%
	\else%
	homework\msfhomework@number_answers%
	\fi%
}
\newcommand{\addanswer}[1]{% Input the section name
	\begin{answer}\ExecuteMetaData[\answerfile]{#1}\end{answer}
}

\newcommand{\file}[1]{%
	\addtocounter{chapter}{1}%
	\section{#1}\label{sec:#1}
}