# Build fit_cover_calibration_hakai_nereo, a pre-fit Nereocystis cover
# calibration model on Hakai Institute data. Fitted with the default chains and
# draws, thinned by 2 and with adapt_delta 0.99 to converge, to the wet biomass
# per m2 of the in situ surveys in data_in_situ_hakai_nereo (built by
# data-raw/data_hakai.R), predicted from fit_weight_hakai_nereo and
# fit_size_hakai_nereo.
# Reproducibility comes from the seeds.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, the data change, or
# fit_weight_hakai_nereo or fit_size_hakai_nereo is rebuilt.
# Run from the package root:
#   Rscript data-raw/fit_cover_calibration_hakai_nereo.R

load("data/fit_weight_hakai_nereo.rda")
load("data/fit_size_hakai_nereo.rda")

load("data/data_in_situ_hakai_nereo.rda")

# Sites or years new to a reference fit take sampled effects.
set.seed(42)
biomass <- kelpbio::kb_predict_biomass_in_situ(
  fit_weight_hakai_nereo,
  fit_size_hakai_nereo,
  data_in_situ_hakai_nereo,
  progress = "none"
)

fit_cover_calibration_hakai_nereo <- kelpbio::kb_fit_cover_calibration_nereo(
  biomass,
  nthin = 2L,
  cores = 4L,
  progress = "bar",
  seed = 42L,
  control = list(adapt_delta = 0.99)
)

usethis::use_data(fit_cover_calibration_hakai_nereo, overwrite = TRUE)
