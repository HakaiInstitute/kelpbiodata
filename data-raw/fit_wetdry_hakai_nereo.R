# Build fit_wetdry_hakai_nereo, a pre-fit Nereocystis wet/dry model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_wetdry_hakai_nereo (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_wetdry_hakai_nereo.R

load("data/data_wetdry_hakai_nereo.rda")

fit_wetdry_hakai_nereo <- kelpbio::kb_fit_wetdry_nereo(
  data_wetdry_hakai_nereo,
  cores = 4L,
  progress = "bar",
  seed = 42L
)

usethis::use_data(fit_wetdry_hakai_nereo, overwrite = TRUE)
