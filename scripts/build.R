# Dev build / QC script for kelpbiodata.
#
#   Rscript scripts/build.R          document, install
#   Rscript scripts/build.R --check  + R CMD check
#   Rscript scripts/build.R --site   + build the pkgdown site
#
# Flags combine (--check --site). Also available as Positron / VS Code tasks
# "kelpbiodata: ..." (.vscode/tasks.json). Linting is handled by jarl in CI
# (.github/workflows/lint-with-jarl.yaml, configured by jarl.toml).

usage <- paste(
  "Usage: Rscript scripts/build.R [--check] [--site]",
  "  --check  also run R CMD check",
  "  --site   also build the pkgdown site",
  sep = "\n"
)
args <- commandArgs(trailingOnly = TRUE)
if (any(c("--help", "-h") %in% args)) {
  cat(usage, "\n", sep = "")
  quit(status = 0)
}
unknown <- setdiff(args, c("--check", "--site"))
if (length(unknown)) {
  cat("Unknown option: ", paste(unknown, collapse = " "), "\n\n", usage, "\n", sep = "")
  quit(status = 1)
}

full_check <- "--check" %in% args
build_site <- "--site" %in% args
message(
  "Build: document, install",
  if (full_check) " + R CMD check",
  if (build_site) " + pkgdown"
)

devtools::document()
devtools::install(build = FALSE, quick = TRUE, upgrade = FALSE)

if (full_check) {
  devtools::check()
}

if (build_site) {
  pkgdown::build_site()
}
