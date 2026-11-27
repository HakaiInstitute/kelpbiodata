# Build fit_nitrogen_hakai_nereo, a pre-fit Nereocystis nitrogen model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_nitrogen_hakai_nereo (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed from GitHub at the commit the fit is for; the
# commit is saved as the fit's kelpbio_commit attribute. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_nitrogen_hakai_nereo.R

source("data-raw/kelpbio_commit.R")
commit <- kelpbio_commit()

load("data/data_nitrogen_hakai_nereo.rda")

fit_nitrogen_hakai_nereo <- kelpbio::kb_fit_nitrogen_nereo(
  data_nitrogen_hakai_nereo,
  progress = "bar",
  seed = 42L
)

attr(fit_nitrogen_hakai_nereo, "kelpbio_commit") <- commit

usethis::use_data(fit_nitrogen_hakai_nereo, overwrite = TRUE)
