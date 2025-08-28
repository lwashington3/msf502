#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Input the information for the class as arguments. Check --help for an example."
	exit 0
elif [ $# -eq 1 ]; then
	if [ "$1" == "--help" ]; then
		echo "This script personalizes the repository for your class. Enter the information as follows: \`./personalize.sh CS 487 \"Software Engineering\"\`."
		exit 0
	fi
fi

if [ ! -f src/styles/tex/latex/iitacademics/iitacademics.sty ]; then
    git submodule init
    git submodule update --remote
fi

SUBJECT=$1
CLASS_NUMBER=$2
CLASS_NAME="$3"

UPPER_SUBJECT="${SUBJECT^^}"
LOWER_SUBJECT="${SUBJECT,,}"

UPPER_ABBR="$UPPER_SUBJECT $CLASS_NUMBER"
LOWER_ABBR="$LOWER_SUBJECT$CLASS_NUMBER"
TITLE="$UPPER_ABBR - $CLASS_NAME"

echo -n "$TITLE" >> .idea/.name
mv .idea/IITAcademics.iml ".idea/$TITLE.iml"
echo """
6i
      <sourceFolder url=\"file://\$MODULE_DIR\$/src/styles/tex/latex/$LOWER_ABBR\" isTestSource=\"false\" />
      <sourceFolder url=\"file://\$MODULE_DIR\$/src/styles/tex/latex/${LOWER_ABBR}notes\" isTestSource=\"false\" />
.
w
q""" | ed ".idea/$TITLE.iml"
sed -i "s/IITAcademics/$TITLE/g" .idea/modules.xml

# TODO: Still need to edit this files
sed -i "s/\bacademics\b/$LOWER_ABBR/g" src/styles/tex/latex/academics/academics.sty
sed -i "s/\baca\b/$LOWER_SUBJECT/g" src/styles/tex/latex/academics/academics.sty
sed -i "s/\[]{subject}/[{$CLASS_NAME}]{subject}/g" src/styles/tex/latex/academics/academics.sty
sed -i "s/\[]{subjectCode}/[{$UPPER_ABBR}]{subjectCode}/g" src/styles/tex/latex/academics/academics.sty
sed -i "s/12\/26\/23/$(date +"%m\/%d\/%Y")/g" src/styles/tex/latex/academics/academics.sty
sed -i "s/2023\/12\/26 A styling package for the class: /$(date +"%Y\/%m\/%d") A styling package for the class: $TITLE./g" src/styles/tex/latex/academics/academics.sty

mv src/styles/tex/latex/academics "src/styles/tex/latex/$LOWER_ABBR"
mv "src/styles/tex/latex/$LOWER_ABBR/academics.sty" "src/styles/tex/latex/$LOWER_ABBR/$LOWER_ABBR.sty"

git add .idea/IITAcademics.iml .idea/modules.xml src/styles/tex/latex/academics/academics.sty src/styles/tex/latex/iitacademics .idea/.name src/styles/tex/latex/$LOWER_ABBR/ ".idea/$TITLE.iml"
git rm personalize.sh
git commit -m "Personalized $TITLE repo."
