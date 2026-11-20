#' Data attribution
#'
#' The attribution statement for the data in kelpbiodata, to include in any
#' output that uses the reference datasets or fits.
#'
#' @return A string.
#' @export
#' @examples
#' kelpbiodata_attribution()
kelpbiodata_attribution <- function() {
  # The statement is kept in a UTF-8 file, as it holds non-ASCII characters.
  path <- system.file("attribution.txt", package = "kelpbiodata")
  paste(readLines(path, encoding = "UTF-8", warn = FALSE), collapse = " ")
}
