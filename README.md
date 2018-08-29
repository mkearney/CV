VITA
================

## My CV repo

Built using \\LaTeX.

``` r
## compile into PDF
system("xelatex cv.tex")

## remove auxiliary files
system("rm *.out *.log *.aux *.synctex.gz")

if (file.exists("~/Website/mikewk.com")) {
  system("cp cv.pdf ~/Website/mikewk.com/static/cv/cv.pdf")
}

## open PDF
browseURL("cv.pdf")
```
