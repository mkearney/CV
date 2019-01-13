## install {tfse} from github
if (!requireNamespace("tfse", quietly = TRUE)) {
  if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
  }
  remotes::install_github("mkearney/tfse")
}

## install {here}
if (!requireNamespace("here", quietly = TRUE)) {
  install.packages("here")
}

## check for xelatex
if (identical(Sys.which("xelatex"), "")) {
  m <- tfse::pmsg(
    "Build requires 'xelatex' (a unicode \\LaTeX engine), ",
    "which was not found on this machine",
    print = FALSE
  )
  stop(m, call. = FALSE)
}

make_cv <- function() {
  tfse::print_start("Updating badges...")
  source(here::here("R/svg.R"))
  tfse::print_complete("Badges up to date")
  cv.tex <- here::here("cv.tex")
  tfse::print_start("Compiling CV...")
  sh <- system(glue::glue("xelatex {cv.tex}"), intern = TRUE)
  tfse::print_complete("CV successfully built!")
  tfse::print_start("Removing build files...")
  .aux <- paste0(dirname(cv.tex), "/", c("*.out", "*.log", "*.aux"))
  sh <- lapply(glue::glue("rm {.aux}"), system)
  tfse::print_complete("All cleaned up!")
}

format_author_name <- function(name) {
  has_comma <- grepl("\\,", name)
  lastname <- character(length(name))
  lastname[!has_comma] <- tfse::regmatches_first(name[!has_comma], "\\S+$")
  name[!has_comma] <- sub("\\s?\\S+$", "", name[!has_comma])
  lastname[has_comma] <- tfse::regmatches_first(name[has_comma], "^\\S+(?=\\,)")
  name[has_comma] <- sub("^\\S+\\,\\s?", "", name[has_comma])
  initials <- gsub("(?<=[A-Z])\\S{0,}", ".", name, perl = TRUE)
  x <- paste0(lastname, ", ", initials)
  if (length(x) > 1L) {
    x[length(x)] <- paste("\\&", x[length(x)])
  }
  paste(x, collapse = ", ")
}

make_cv()

format_articles <- function() {
  author <- sapply(x$author, format_author_name)
  author <- paste0("\\item ", author)
  x$volume[is.na(x$volume)] <- ""
  if (!"booktitle" %in% names(x)) {
    x$booktitle <- NA_character_
  }
  x$journal[is.na(x$journal) && !is.na(x$booktitle)] <- x$booktitle[
    is.na(x$journal) && !is.na(x$booktitle)]
  x$journal[is.na(x$journal)] <- ""
  x$pages[is.na(x$pages)] <- ""
  journal <- ifelse(
    "" == x$volume & "" == x$pages,
    paste0("\\textit{", x$journal, "}."),
    ifelse(
      "" == x$volume,
      paste0("\\textit{", x$journal, "}, ", x$pages, "."),
      ifelse(x$pages == "",
        paste0("\\textit{", x$journal, "., ", x$volume, "}."),
        paste0("\\textit{", x$journal, "., ", x$volume, "}.", " ",
          x$pages, "."))
  ))
  title <- x$title
  year <- paste0("(", x$year, ")")
  if (!"doi" %in% names(x)) {
    x$doi <- ""
  }
  x$doi[is.na(x$doi)] <- ""
  doi <- sub("https?://doi.org/", "", x$doi)
  doi <- ifelse(doi == "", "\n",
    paste0("\\href{https://doi.org/", doi, "}{", doi, "}\n"))
  entries <- paste0(
    author, " ", year, ".\n    ",
    title, ",\n    ",
    journal, "\n    ",
    doi
  )
  entries
}
#x <- bib2df::bib2df("~/Dropbox/gs.bib")
#names(x) <- tolower(names(x))
#format_articles(x)

#a <- bibtex::read.bib("tex/articles-bib.bib")
#o <- capture.output(print(a, style = "latex"))
#tmp <- tempfile(fileext = ".tex")
#cat(tfse:::paste_lines(o), file = tmp)
#system(glue::glue("open -a rstudio {tmp}"))
