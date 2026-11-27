# The kelpbio commit a fit is made with, saved as the fit's kelpbio_commit
# attribute. kelpbio must be installed from GitHub (for example
# pak::pak("HakaiInstitute/kelpbio@<commit>")) for the commit to be known.
kelpbio_commit <- function() {
  sha <- utils::packageDescription("kelpbio")$RemoteSha
  if (is.null(sha)) {
    stop("Install kelpbio from GitHub so its commit can be recorded.", call. = FALSE)
  }
  sha
}
