%! Class = msf502notes.cls
%! Author = Len Washington III
%! Date = 9/2/25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msf502notes}[Len Washington III's Document Class]

\LoadClass[12pt]{report}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family=msfnotes,
	prefix=msfnotes@
}

\DeclareStringOption{lecture}
\DeclareStringOption{title}
\DeclareBoolOption[true]{answers}
\DeclareBoolOption[false]{corrections}

\ProcessKeyvalOptions*

\renewcommand{\title}{MSF 502 - Lecture\ \msfnotes@lecture\ - \msfnotes@title}

\RequirePackage[
	title={\title},
]{msf502}

\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{
%MSF 502 - Lecture \msfnotes@lecture
\setcounter{chapter}{\msfnotes@lecture}
\addtocounter{chapter}{-1}
\chapter{\msfnotes@title}\label{ch:\msfnotes@lecture}
}

\RequirePackage{makecell}
\usetikzlibrary{shapes.geometric}

\RequirePackage{ulem}
\RequirePackage{enumitem}

\RequirePackage[most]{tcolorbox}
\newcounter{learningobjective}[chapter]
\definecolor{objectiveblue}{HTML}{2d2d8a}
\newcommand{\lo}[1]{
	\stepcounter{learningobjective}%
	\begin{tcolorbox}[colback=objectiveblue, colframe=objectiveblue]%
	\color{white}
	\label{lo:\arabic{chapter}.\arabic{learningobjective}}
	LO \arabic{chapter}.\arabic{learningobjective} \textbf{#1}
	\end{tcolorbox}
}

\definecolor{objectivescyan}{HTML}{bbe0e3}
\newlist{objectives}{enumerate}{1}
\setlist[objectives,1]{label=%
	\hyperref[lo:\arabic{chapter}.\arabic{objectivesi}]{%
		\textcolor{objectivescyan}{\textbf{%
			LO \arabic{chapter}.\arabic{objectivesi}:%
		}}
	}
}