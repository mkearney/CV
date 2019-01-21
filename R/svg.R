
## possible colors
##"brightgreen", "green", "yellowgreen", "yellow", "orange", "red", "lightgrey", "blue"

download_file <- function(url, destfile) {
  download.file(url, destfile, quiet = TRUE)
}

downloads_badge <- function(pkg, color, file = NULL) {
  url <- paste0(
    "https://cranlogs.r-pkg.org/badges/grand-total/",
    pkg, "?color=", color
  )
  tmp <- tempfile()
  download_file(url, destfile = tmp)
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
  download_file(url, destfile = tmp)
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

downloads_badge("dapr", "yellowgreen", here::here("img", "dapr-downloads.pdf"))
downloads_badge("rtweet", "yellowgreen", here::here("img", "rtweet-downloads.pdf"))
downloads_badge("textfeatures", "yellowgreen", here::here("img", "textfeatures-downloads.pdf"))
downloads_badge("tfse", "yellowgreen", here::here("img", "tfse-downloads.pdf"))
downloads_badge("tbltools", "yellowgreen", here::here("img", "tbltools-downloads.pdf"))
downloads_badge("funique", "yellowgreen", here::here("img", "funique-downloads.pdf"))
downloads_badge("pkgverse", "yellowgreen", here::here("img", "pkgverse-downloads.pdf"))

if (FALSE) {
  dapr = "153846249"
  pkgverse = "136514892"
  tbltools  = "152122857"
  tfse = "62493045"
  funique = "133566034"
  textfeatures = "123046986"
  rtweet = "64161359"

  zenodo_badge(dapr, here::here("img", "dapr-doi.pdf"))
  zenodo_badge(pkgverse, here::here("img", "pkgverse-doi.pdf"))
  zenodo_badge(tbltools, here::here("img", "tbltools-doi.pdf"))
  zenodo_badge(tfse, here::here("img", "tfse-doi.pdf"))
  zenodo_badge(funique, here::here("img", "funique-doi.pdf"))
  zenodo_badge(textfeatures, here::here("img", "textfeatures-doi.pdf"))
  zenodo_badge(rtweet, here::here("img", "rtweet-doi.pdf"))

}
