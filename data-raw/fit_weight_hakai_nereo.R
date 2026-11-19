# Build fit_weight_hakai_nereo, a pre-fit Nereocystis weight model on Hakai
# Institute data. Fitted with the default chains and draws, thinned by 2 to
# converge, to data_weight_hakai_nereo (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_weight_hakai_nereo.R

load("data/data_weight_hakai_nereo.rda")

fit_weight_hakai_nereo <- kelpbio::kb_fit_weight_nereo(
  data_weight_hakai_nereo,
  nthin = 2L,
  cores = 4L,
  progress = "bar",
  seed = 42L,
  control = list(adapt_delta = 0.99)
)

usethis::use_data(fit_weight_hakai_nereo, overwrite = TRUE)
