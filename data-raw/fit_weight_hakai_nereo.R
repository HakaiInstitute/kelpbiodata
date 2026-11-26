# Build fit_weight_hakai_nereo, a pre-fit Nereocystis weight model on Hakai
# Institute data. Fitted with the default chains and draws, thinned by 2 to
# converge, to data_weight_hakai_nereo (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed from GitHub at the commit the fit is for; the
# commit is saved as the fit's kelpbio_commit attribute. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_weight_hakai_nereo.R

source("data-raw/kelpbio_commit.R")
commit <- kelpbio_commit()

load("data/data_weight_hakai_nereo.rda")

fit_weight_hakai_nereo <- kelpbio::kb_fit_weight_nereo(
  data_weight_hakai_nereo,
  nthin = 2L,
  progress = "bar",
  seed = 42L,
  control = list(adapt_delta = 0.99)
)

attr(fit_weight_hakai_nereo, "kelpbio_commit") <- commit

usethis::use_data(fit_weight_hakai_nereo, overwrite = TRUE)
