# Build fit_nitrogen_hakai_macro, a pre-fit Macrocystis nitrogen model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_nitrogen_hakai_macro (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_nitrogen_hakai_macro.R

load("data/data_nitrogen_hakai_macro.rda")

fit_nitrogen_hakai_macro <- kelpbio::kb_fit_nitrogen_macro(
  data_nitrogen_hakai_macro,
  progress = "bar",
  seed = 42L
)

usethis::use_data(fit_nitrogen_hakai_macro, overwrite = TRUE)
