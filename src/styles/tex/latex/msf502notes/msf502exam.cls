%! Class = msf502exam.cls
%! Author = Len Washington III
%! Date = 9/2/25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msf502exam}[Len Washington III's Document Class]

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family=msfexam,
	prefix=msfexam@
}

\DeclareStringOption{title}

\ProcessKeyvalOptions*

\renewcommand{\title}{MSF 502 - Exam\ \msfexam@title\ Notes}

\LoadClass[title={\title},abbreviated=true]{msf502notes}
\renewcommand{\title}{MSF 502 - Exam\ \msfexam@title\ Notes}

\hypersetup{linkcolor=black}
\definecolor{objectiveblue}{HTML}{797C7D}
\definecolor{objectivescyan}{HTML}{626561}

% Removes pagebreak for chapters
\makeatletter
\renewcommand\chapter{\par%
\thispagestyle{plain}%
\global\@topnum\z@
\@afterindentfalse
\secdef\@chapter\@schapter}
\makeatother

\RequirePackage[fontsize=6pt]{fontsize}