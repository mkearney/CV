#https://www.r-pkg.org/badges/last-release/rtweet
## possible colors
##"brightgreen", "green", "yellowgreen", "yellow", "orange", "red", "lightgrey", "blue"

download_file <- function(url, destfile) {
  download.file(url, destfile, quiet = TRUE)
}

cran_badge <- function(pkg, file = NULL) {
  url <- paste0(
    "http://www.r-pkg.org/badges/version/", pkg, "?color=green"
  )
  tmp <- tempfile()
  download_file(url, destfile = tmp)
  x <- tfse::readlines(tmp)
  x <- gsub('font-size="11"', 'font-size="13"', x)
  tmp2 <- tempfile(fileext = ".svg")
  writeLines(x, tmp2)
  save_as <- fml::here("img", sprintf("%s-cran.pdf", pkg))
  rsvg::rsvg_pdf(tmp2, save_as)
  invisible(file)
}

downloads_badge <- function(pkg, color, file = NULL) {
  url <- paste0(
    "https://cranlogs.r-pkg.org/badges/grand-total/",
    pkg, "?color=", color
  )
  tmp <- tempfile()
  download_file(url, destfile = tmp)
  x <- tfse::readlines(tmp)
  x <- gsub('font-size="11"', 'font-size="13"', x)
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
  x <- gsub('font-size="11"', 'font-size="13"', x)
  tmp2 <- tempfile(fileext = ".svg")
  writeLines(x, tmp2)
  if (is.null(file)) {
    file <- tempfile(fileext = ".pdf")
  }
  rsvg::rsvg_pdf(tmp2, file)
  invisible(file)
}

if (grepl("darwin", R.version$os)) {

  downloads_badge("googler", "ff69b4",
    here::here("img", "googler-downloads.pdf"))
  downloads_badge("readthat", "ff69b4",
    here::here("img", "readthat-downloads.pdf"))
  downloads_badge("dapr", "ff69b4",
    here::here("img", "dapr-downloads.pdf"))
  downloads_badge("rtweet", "ff69b4",
    here::here("img", "rtweet-downloads.pdf"))
  downloads_badge("textfeatures", "ff69b4",
    here::here("img", "textfeatures-downloads.pdf"))
  downloads_badge("tfse", "ff69b4",
    here::here("img", "tfse-downloads.pdf"))
#  downloads_badge("tbltools", "ff69b4",
#    here::here("img", "tbltools-downloads.pdf"))
  downloads_badge("funique", "ff69b4",
    here::here("img", "funique-downloads.pdf"))
  downloads_badge("pkgverse", "ff69b4",
    here::here("img", "pkgverse-downloads.pdf"))

  if (TRUE) {
    googler = "205187636"
    readthat = "20985412"
    dapr = "153846249"
    pkgverse = "136514892"
#    tbltools  = "152122857"
    tfse = "62493045"
    funique = "133566034"
    textfeatures = "123046986"
    rtweet = "64161359"

    zenodo_badge(dapr, here::here("img", "googler-doi.pdf"))
    zenodo_badge(dapr, here::here("img", "readthat-doi.pdf"))
    zenodo_badge(dapr, here::here("img", "dapr-doi.pdf"))
    zenodo_badge(pkgverse, here::here("img", "pkgverse-doi.pdf"))
    #zenodo_badge(tbltools, here::here("img", "tbltools-doi.pdf"))
    zenodo_badge(tfse, here::here("img", "tfse-doi.pdf"))
    zenodo_badge(funique, here::here("img", "funique-doi.pdf"))
    zenodo_badge(textfeatures, here::here("img", "textfeatures-doi.pdf"))
    zenodo_badge(rtweet, here::here("img", "rtweet-doi.pdf"))
  }


  if (TRUE) {
    cran_badge("googler")
    cran_badge("readthat")
    cran_badge("dapr")
    cran_badge("pkgverse")
#    cran_badge("tbltools")
    cran_badge("tfse")
    cran_badge("funique")
    cran_badge("textfeatures")
    cran_badge("rtweet")
  }
}
