#!/bin/bash
# pandoc --pdf-engine=xelatex $(ls | grep -E '^lesson[[:digit:]]\.md$|title\.md') -o bash.pdf

pandoc --pdf-engine=xelatex $(cat pdf.list) -o bash.pdf