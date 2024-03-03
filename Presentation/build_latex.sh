#!/bin/bash

lualatex template.tex
biber template
lualatex template.tex
lualatex template.tex
