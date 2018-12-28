
## possible colors
##"brightgreen", "green", "yellowgreen", "yellow", "orange", "red", "lightgrey", "blue"

downloads_badge <- function(pkg, color, file = NULL) {
  url <- paste0(
    "https://cranlogs.r-pkg.org/badges/grand-total/",
    pkg, "?color=", color
  )
  tmp <- tempfile()
  download.file(url, destfile = tmp)
  x <- tfse::readlines(tmp)
  x <- sub('.*font-size="11"', 'font-size="16" font-family="\'PT Sans\'"', x)
  #x <- sub('font-family="DejaVu Sans,', 'font-family="Menlo"', x)
  tmp2 <- tempfile(fileext = ".svg")
  writeLines(x, tmp2)
  if (is.null(file)) {
    file <- tempfile(fileext = ".pdf")
  }
  rsvg::rsvg_pdf(tmp2, file)
  invisible(file)
}

zenodo_badge <- function(num, file = NULL) {
  url <- paste0("https://zenodo.org/badge/", num, ".svg")
  tmp <- tempfile()
  download.file(url, destfile = tmp)
  x <- tfse::readlines(tmp)
  x <- sub('.*font-size="11"', 'font-size="16"', x)
  x <- sub('font-family="DejaVu Sans,', 'font-family="\'PT Sans\'"', x)
  tmp2 <- tempfile(fileext = ".svg")
  writeLines(x, tmp2)
  if (is.null(file)) {
    file <- tempfile(fileext = ".pdf")
  }
  rsvg::rsvg_pdf(tmp2, file)
  invisible(file)
}

downloads_badge("rtweet", "yellowgreen", "img/rtweet-downloads.pdf")
downloads_badge("textfeatures", "yellowgreen", "img/textfeatures-downloads.pdf")


dapr = "153846249"
pkgverse = "136514892"
tbltools  = "152122857"
tfse = "62493045"
funique = "133566034"
textfeatures = "123046986"
rtweet = "64161359"

zenodo_badge(dapr, "img/dapr-doi.pdf")
zenodo_badge(pkgverse, "img/pkgverse-doi.pdf")
zenodo_badge(tbltools, "img/tbltools-doi.pdf")
zenodo_badge(tfse, "img/tfse-doi.pdf")
zenodo_badge(funique, "img/funique-doi.pdf")
zenodo_badge(textfeatures, "img/textfeatures-doi.pdf")
zenodo_badge(rtweet, "img/rtweet-doi.pdf")




