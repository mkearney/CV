## install {tfse} from github
if (!requireNamespace("tfse", quietly = TRUE)) {
  if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
  }
  remotes::install_github("mkearney/tfse")
}

## install {rsvg}
if (!requireNamespace("rsvg", quietly = TRUE)) {
  install.packages("rsvg")
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
  if (!file.exists(svg.r <- "R/svg.R")) {
    svg.r <- "../R/svg.R"
  }
  source(svg.r)
  tfse::print_complete("Badges up to date")
  if (!file.exists(cv.tex <- "cv.tex")) {
    cv.tex <- "../cv.tex"
  }
  tfse::print_start("Compiling CV...")
  sh <- system(glue::glue("xelatex {cv.tex}"), intern = TRUE)
  sh <- system(glue::glue("xelatex {cv.tex}"), intern = TRUE)
  tfse::print_complete("CV successfully built!")
  tfse::print_start("Removing build files...")
  cv.build <- list.files(dirname(cv.tex),
    pattern = "cv\\.", full.names = TRUE)
  cv.build <- grep("\\.tex$|\\.pdf$", cv.build, invert = TRUE, value = TRUE)
  unlink(cv.build)
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


## add to git, commit, and push
if (!file.exists("cv.tex")) {
  setwd("..")
}

system("git pull")
git2r::add(path = ".")
git2r::commit(message = "update")
system("git push")
