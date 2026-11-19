# Built by data-raw/fit_carbon_hakai_macro.R.
#' Hakai Institute Macrocystis carbon fit
#'
#' A fit of `kelpbio::kb_fit_carbon_macro()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting dry
#' biomass to carbon without fitting a carbon model.
#'
#' @format An object of class
#'   `c("kb_fit_carbon_macro", "kb_fit_carbon", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_carbon_macro()` and [data_carbon_hakai_macro] for
#'   the data.
#' @family reference fits
"fit_carbon_hakai_macro"

# Built by data-raw/fit_carbon_hakai_nereo.R.
#' Hakai Institute Nereocystis carbon fit
#'
#' A fit of `kelpbio::kb_fit_carbon_nereo()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting dry
#' biomass to carbon without fitting a carbon model.
#'
#' @format An object of class
#'   `c("kb_fit_carbon_nereo", "kb_fit_carbon", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_carbon_nereo()` and [data_carbon_hakai_nereo] for
#'   the data.
#' @family reference fits
"fit_carbon_hakai_nereo"

# Built by data-raw/fit_cover_calibration_hakai_macro.R.
#' Hakai Institute Macrocystis cover calibration fit
#'
#' A fit of `kelpbio::kb_fit_cover_calibration_macro()` to Hakai Institute in
#' situ surveys in British Columbia, each paired with a drone flight, for
#' predicting canopy biomass with `kelpbio::kb_predict_biomass_canopy()` without
#' fitting a calibration. Each survey's wet biomass per m² is predicted by
#' `kelpbio::kb_predict_biomass_in_situ()` from [fit_weight_hakai_macro] and
#' every plant counted on its transects with at least one frond at 1 m; the
#' plants of site `"HAK012"` take the weight effect of `"HAK042"`, one of its
#' two plots.
#'
#' @format An object of class
#'   `c("kb_fit_cover_calibration_macro", "kb_fit_cover_calibration", "kb_fit")`.
#'   The data are in `fit$data`.
#' @seealso `kelpbio::kb_fit_cover_calibration_macro()`,
#'   [data_in_situ_hakai_macro] for the surveys, and
#'   [data_size_census_hakai_macro] for their plants.
#' @family reference fits
"fit_cover_calibration_hakai_macro"

# Built by data-raw/fit_cover_calibration_hakai_nereo.R.
#' Hakai Institute Nereocystis cover calibration fit
#'
#' A fit of `kelpbio::kb_fit_cover_calibration_nereo()` to Hakai Institute in
#' situ surveys in British Columbia, each paired with a drone flight, for
#' predicting canopy biomass with `kelpbio::kb_predict_biomass_canopy()` without
#' fitting a calibration. Each survey's wet biomass per m² is predicted by
#' `kelpbio::kb_predict_biomass_in_situ()` from [fit_weight_hakai_nereo] and
#' [fit_size_hakai_nereo]. Surveys with no plants counted are included. Surveys
#' in site-years whose plants were sized only by cumulative blade length are
#' excluded.
#'
#' @format An object of class
#'   `c("kb_fit_cover_calibration_nereo", "kb_fit_cover_calibration", "kb_fit")`.
#'   The data are in `fit$data`.
#' @seealso `kelpbio::kb_fit_cover_calibration_nereo()` and
#'   [data_in_situ_hakai_nereo] for the surveys.
#' @family reference fits
"fit_cover_calibration_hakai_nereo"

# Built by data-raw/fit_nitrogen_hakai_macro.R.
#' Hakai Institute Macrocystis nitrogen fit
#'
#' A fit of `kelpbio::kb_fit_nitrogen_macro()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting dry
#' biomass to nitrogen without fitting a nitrogen model.
#'
#' @format An object of class
#'   `c("kb_fit_nitrogen_macro", "kb_fit_nitrogen", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_nitrogen_macro()` and [data_nitrogen_hakai_macro]
#'   for the data.
#' @family reference fits
"fit_nitrogen_hakai_macro"

# Built by data-raw/fit_nitrogen_hakai_nereo.R.
#' Hakai Institute Nereocystis nitrogen fit
#'
#' A fit of `kelpbio::kb_fit_nitrogen_nereo()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting dry
#' biomass to nitrogen without fitting a nitrogen model.
#'
#' @format An object of class
#'   `c("kb_fit_nitrogen_nereo", "kb_fit_nitrogen", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_nitrogen_nereo()` and [data_nitrogen_hakai_nereo]
#'   for the data.
#' @family reference fits
"fit_nitrogen_hakai_nereo"

# Built by data-raw/fit_size_hakai_nereo.R.
#' Hakai Institute Nereocystis size fit
#'
#' A fit of `kelpbio::kb_fit_size_nereo()` to maximum sub-bulb diameters
#' measured in July and August, the peak season, in Hakai Institute surveys in
#' British Columbia.
#'
#' @format An object of class `c("kb_fit_size_nereo", "kb_fit_size", "kb_fit")`.
#'   The data are in `fit$data`.
#' @seealso `kelpbio::kb_fit_size_nereo()` and [data_size_sample_hakai_nereo]
#'   for the data.
#' @family reference fits
"fit_size_hakai_nereo"

# Built by data-raw/fit_weight_hakai_macro.R.
#' Hakai Institute Macrocystis weight fit
#'
#' A fit of `kelpbio::kb_fit_weight_macro()` to plants harvested by the Hakai
#' Institute in British Columbia.
#'
#' @format An object of class
#'   `c("kb_fit_weight_macro", "kb_fit_weight", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_weight_macro()` and [data_weight_hakai_macro] for
#'   the data.
#' @family reference fits
"fit_weight_hakai_macro"

# Built by data-raw/fit_weight_hakai_nereo.R.
#' Hakai Institute Nereocystis weight fit
#'
#' A fit of `kelpbio::kb_fit_weight_nereo()` to plants harvested by the Hakai
#' Institute in British Columbia after day of year 140, measured at the maximum
#' sub-bulb diameter.
#'
#' @format An object of class
#'   `c("kb_fit_weight_nereo", "kb_fit_weight", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_weight_nereo()` and [data_weight_hakai_nereo] for
#'   the data.
#' @family reference fits
"fit_weight_hakai_nereo"

# Built by data-raw/fit_wetdry_hakai_macro.R.
#' Hakai Institute Macrocystis wet/dry fit
#'
#' A fit of `kelpbio::kb_fit_wetdry_macro()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting wet
#' biomass to dry without fitting a wet/dry model.
#'
#' @format An object of class
#'   `c("kb_fit_wetdry_macro", "kb_fit_wetdry", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_wetdry_macro()` and [data_wetdry_hakai_macro] for
#'   the data.
#' @family reference fits
"fit_wetdry_hakai_macro"

# Built by data-raw/fit_wetdry_hakai_nereo.R.
#' Hakai Institute Nereocystis wet/dry fit
#'
#' A fit of `kelpbio::kb_fit_wetdry_nereo()` to Hakai Institute tissue samples
#' in British Columbia, all months and tissues pooled, for converting wet
#' biomass to dry without fitting a wet/dry model.
#'
#' @format An object of class
#'   `c("kb_fit_wetdry_nereo", "kb_fit_wetdry", "kb_fit")`. The data are in
#'   `fit$data`.
#' @seealso `kelpbio::kb_fit_wetdry_nereo()` and [data_wetdry_hakai_nereo] for
#'   the data.
#' @family reference fits
"fit_wetdry_hakai_nereo"
