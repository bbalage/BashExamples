#!/bin/bash

pandoc --pdf-engine=xelatex $(ls | grep -E '^lesson[[:digit:]]\.md$|title\.md') -o bash.pdf