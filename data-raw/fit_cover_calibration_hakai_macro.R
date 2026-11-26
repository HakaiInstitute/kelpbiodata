# Build fit_cover_calibration_hakai_macro, a pre-fit Macrocystis cover
# calibration model on Hakai Institute data. Fitted with the default chains and
# draws, thinned by 2 and with adapt_delta 0.99 for sd_site to converge, to the
# wet biomass per m2 of the
# in situ surveys in data_in_situ_hakai_macro and
# data_size_census_hakai_macro (built by data-raw/data_hakai.R),
# predicted from fit_weight_hakai_macro and the size census.
# Reproducibility comes from the seeds.
#
# Requires kelpbio installed at the version the fit is for. Re-run whenever
# kelpbio changes the model or the kb_fit object structure, the data change, or
# fit_weight_hakai_macro is rebuilt.
# Run from the package root:
#   Rscript data-raw/fit_cover_calibration_hakai_macro.R

load("data/fit_weight_hakai_macro.rda")

load("data/data_in_situ_hakai_macro.rda")
load("data/data_size_census_hakai_macro.rda")

# Sites or years new to a reference fit take sampled effects, except HAK012:
# its two plots share one canopy map, and its plants are weighed with the effect
# of the harvests from one of them, HAK042.
predict_biomass <- function(survey, ...) {
  kelpbio::kb_predict_biomass_in_situ(
    fit_weight_hakai_macro,
    dplyr::semi_join(data_size_census_hakai_macro, survey, by = "survey_id"),
    survey,
    ...,
    progress = "none"
  )
}

shared <- data_in_situ_hakai_macro$site == "HAK012"

set.seed(42)
biomass <- rbind(
  predict_biomass(data_in_situ_hakai_macro[!shared, ]),
  predict_biomass(
    data_in_situ_hakai_macro[shared, ],
    representative_site = list(weight = "HAK042")
  )
)

fit_cover_calibration_hakai_macro <- kelpbio::kb_fit_cover_calibration_macro(
  biomass,
  control = list(adapt_delta = 0.99),
  nthin = 2L,
  progress = "bar",
  seed = 42L
)

usethis::use_data(fit_cover_calibration_hakai_macro, overwrite = TRUE)
