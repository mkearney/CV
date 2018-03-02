VITA
================

## My CV repo

Built using \\LaTeX.

``` r
## compile into PDF
system("xelatex tex/CV.tex")

## remove auxiliary files
system("rm *.out *.log *.aux")

## open PDF
browseURL("cv.pdf")
```
