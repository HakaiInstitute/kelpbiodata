# Build fit_carbon_hakai_macro, a pre-fit Macrocystis carbon model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_carbon_hakai_macro (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_carbon_hakai_macro.R

load("data/data_carbon_hakai_macro.rda")

fit_carbon_hakai_macro <- kelpbio::kb_fit_carbon_macro(
  data_carbon_hakai_macro,
  cores = 4L,
  progress = "bar",
  seed = 42L
)

usethis::use_data(fit_carbon_hakai_macro, overwrite = TRUE)
