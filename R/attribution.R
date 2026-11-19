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
  paste(
    "The Hakai Institute data in this package were collected in collaboration",
    "with the Heiltsuk First Nation on Heiltsuk territory. Please credit the",
    "Heiltsuk Integrated Resource Management Department and the Hakai Institute",
    "in any outputs that use these data."
  )
}
