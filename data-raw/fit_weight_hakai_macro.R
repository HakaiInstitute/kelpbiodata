# Build fit_weight_hakai_macro, a pre-fit Macrocystis weight model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_weight_hakai_macro (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_weight_hakai_macro.R

load("data/data_weight_hakai_macro.rda")

fit_weight_hakai_macro <- kelpbio::kb_fit_weight_macro(
  data_weight_hakai_macro,
  progress = "bar",
  seed = 42L
)

usethis::use_data(fit_weight_hakai_macro, overwrite = TRUE)
