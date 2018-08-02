VITA
================

## My CV repo

Built using \\LaTeX.

``` r
## compile into PDF
system("xelatex cv.tex")

## remove auxiliary files
system("rm *.out *.log *.aux *.synctex.gz")

## open PDF
browseURL("cv.pdf")
```
