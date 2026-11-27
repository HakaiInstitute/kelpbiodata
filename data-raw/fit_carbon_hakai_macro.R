# Build fit_carbon_hakai_macro, a pre-fit Macrocystis carbon model on Hakai
# Institute data. Fitted with the default chains and draws to
# data_carbon_hakai_macro (built by data-raw/data_hakai.R).
# Reproducibility comes from the sampler `seed`.
#
# Requires kelpbio installed from GitHub at the commit the fit is for; the
# commit is saved as the fit's kelpbio_commit attribute. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, or the data change.
# Run from the package root:
#   Rscript data-raw/fit_carbon_hakai_macro.R

source("data-raw/kelpbio_commit.R")
commit <- kelpbio_commit()

load("data/data_carbon_hakai_macro.rda")

fit_carbon_hakai_macro <- kelpbio::kb_fit_carbon_macro(
  data_carbon_hakai_macro,
  progress = "bar",
  seed = 42L
)

attr(fit_carbon_hakai_macro, "kelpbio_commit") <- commit

usethis::use_data(fit_carbon_hakai_macro, overwrite = TRUE)
