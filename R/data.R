# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis carbon data
#'
#' Sample and carbon masses of Hakai Institute tissue samples in British
#' Columbia, all months and tissues pooled, one row per dried tissue sample.
#'
#' @format A tibble with 190 rows and columns:
#' \describe{
#'   \item{sample_mass_mg}{Mass of the dried sample analysed (mg).}
#'   \item{carbon_mass_ug}{Carbon measured in the sample (µg).}
#' }
#' @source Hakai Institute, unpublished tissue isotope data.
#' @seealso [fit_carbon_hakai_macro] for the fit to this dataset.
#' @family reference datasets
"data_carbon_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis carbon data
#'
#' Sample and carbon masses of Hakai Institute tissue samples in British
#' Columbia, all months and tissues pooled, one row per dried tissue sample.
#'
#' @format A tibble with 185 rows and columns:
#' \describe{
#'   \item{sample_mass_mg}{Mass of the dried sample analysed (mg).}
#'   \item{carbon_mass_ug}{Carbon measured in the sample (µg).}
#' }
#' @source Hakai Institute, unpublished tissue isotope data.
#' @seealso [fit_carbon_hakai_nereo] for the fit to this dataset.
#' @family reference datasets
"data_carbon_hakai_nereo"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis in situ survey data
#'
#' Hakai Institute in situ surveys in British Columbia, each paired with a canopy
#' map, one row per survey. Site `"HAK012"` holds two plots under one canopy map,
#' with a survey of each a year; every other site has one survey a year. The
#' plants each survey counted are listed in [data_size_census_hakai_macro].
#' Sites are identified by code.
#'
#' @format A tibble with 71 rows and columns:
#' \describe{
#'   \item{survey_id}{Survey identifier (`"<plot> <year>"`, where the plot is
#'     the site except at `"HAK012"`), a character string.}
#'   \item{site}{Site code, a factor (8 levels).}
#'   \item{year}{Year, a factor (10 levels, 2016 to 2025).}
#'   \item{survey_area_m2}{Area of the density transects surveyed (m²).}
#'   \item{plot_area_m2}{Plot polygon (m²).}
#'   \item{canopy_area_m2}{Drone canopy within the plot (m²).}
#'   \item{canopy_tide_height_m}{Tide height when the canopy was imaged (m).}
#' }
#' @source Area surveyed from Hakai Institute, *Macrocystis* kelp canopy
#'   productivity, version 1.4.0, <https://doi.org/10.21966/k88j-1k50>.
#'   Canopy for 2015 to 2024 from Hakai Institute, kelp drone mapping data,
#'   version 1.0, <https://doi.org/10.21966/9cbv-ra30>. The 2025 canopy, the
#'   plot polygons and the 2025 tide heights are unpublished.
#' @seealso [fit_cover_calibration_hakai_macro], calibrated to the biomass of
#'   these surveys.
#' @family reference datasets
"data_in_situ_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis in situ survey data
#'
#' Hakai Institute in situ surveys in British Columbia, each paired with a drone
#' flight, one row per survey (one per site-year), including surveys with no
#' plants counted. Surveys in site-years whose plants were sized only by
#' cumulative blade length are excluded.
#'
#' @format A tibble with 39 rows and columns:
#' \describe{
#'   \item{survey_id}{Survey identifier (`"<site> <year>"`), a character
#'     string.}
#'   \item{site}{Site code, a factor (6 levels).}
#'   \item{year}{Year, a factor (7 levels, 2019 to 2025).}
#'   \item{survey_area_m2}{Area of the transects surveyed (m²).}
#'   \item{plants}{Plants counted, an integer.}
#'   \item{plot_area_m2}{Plot polygon (m²).}
#'   \item{canopy_area_m2}{Drone canopy within the plot (m²).}
#'   \item{canopy_tide_height_m}{Tide height when the canopy was imaged (m).}
#' }
#' @source Plants counted from Hakai Institute, *Nereocystis* kelp canopy
#'   productivity, version 1.3.0, <https://doi.org/10.21966/d1s2-s530>.
#'   Canopy for 2015 to 2024 from Hakai Institute, kelp drone mapping data,
#'   version 1.0, <https://doi.org/10.21966/9cbv-ra30>. The 2025 canopy, the
#'   plot polygons and the 2025 tide heights are unpublished.
#' @seealso [fit_cover_calibration_hakai_nereo], calibrated to the biomass of
#'   these surveys.
#' @family reference datasets
"data_in_situ_hakai_nereo"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis nitrogen data
#'
#' Sample and nitrogen masses of Hakai Institute tissue samples in British
#' Columbia, all months and tissues pooled, one row per dried tissue sample.
#'
#' @format A tibble with 191 rows and columns:
#' \describe{
#'   \item{sample_mass_mg}{Mass of the dried sample analysed (mg).}
#'   \item{nitrogen_mass_ug}{Nitrogen measured in the sample (µg).}
#' }
#' @source Hakai Institute, unpublished tissue isotope data.
#' @seealso [fit_nitrogen_hakai_macro] for the fit to this dataset.
#' @family reference datasets
"data_nitrogen_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis nitrogen data
#'
#' Sample and nitrogen masses of Hakai Institute tissue samples in British
#' Columbia, all months and tissues pooled, one row per dried tissue sample.
#'
#' @format A tibble with 188 rows and columns:
#' \describe{
#'   \item{sample_mass_mg}{Mass of the dried sample analysed (mg).}
#'   \item{nitrogen_mass_ug}{Nitrogen measured in the sample (µg).}
#' }
#' @source Hakai Institute, unpublished tissue isotope data.
#' @seealso [fit_nitrogen_hakai_nereo] for the fit to this dataset.
#' @family reference datasets
"data_nitrogen_hakai_nereo"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis size census data
#'
#' Every plant with at least one frond at 1 m above the holdfast counted on the
#' density transects of the surveys in [data_in_situ_hakai_macro], one row per
#' plant.
#'
#' @format A tibble with 2861 rows and columns:
#' \describe{
#'   \item{survey_id}{Survey the plant was counted in, matching its
#'     `survey_id`.}
#'   \item{fronds}{Fronds reaching 1 m above the holdfast, an integer.}
#'   \item{partial}{Whether the plant is counted as half (on the edge of a
#'     transect), a logical.}
#' }
#' @source Hakai Institute, *Macrocystis* kelp canopy productivity, version
#'   1.4.0, <https://doi.org/10.21966/k88j-1k50>.
#' @seealso [fit_cover_calibration_hakai_macro], calibrated to the biomass of
#'   these surveys.
#' @family reference datasets
"data_size_census_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis size sample data
#'
#' Maximum sub-bulb diameters measured in July and August, the peak season, in
#' Hakai Institute surveys in British Columbia, one row per plant.
#'
#' @format A tibble with 2425 rows and columns:
#' \describe{
#'   \item{diameter_mm}{Maximum sub-bulb diameter (mm).}
#'   \item{site}{Site code, a factor (15 levels).}
#'   \item{year}{Year, a factor (7 levels, 2019 to 2025).}
#' }
#' @source Hakai Institute, *Nereocystis* kelp canopy productivity, version
#'   1.3.0, <https://doi.org/10.21966/d1s2-s530>.
#' @seealso [fit_size_hakai_nereo] for the fit to this dataset.
#' @family reference datasets
"data_size_sample_hakai_nereo"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis weight data
#'
#' Frond counts and wet weights of plants harvested by the Hakai Institute in
#' British Columbia, one row per plant.
#'
#' @format A tibble with 292 rows and columns:
#' \describe{
#'   \item{fronds}{Fronds reaching 1 m above the holdfast, an integer.}
#'   \item{weight_kg}{Wet weight (kg).}
#'   \item{site}{Site code, a factor (20 levels).}
#'   \item{year}{Harvest year, a factor (10 levels, 2016 to 2025).}
#' }
#' @source Hakai Institute, *Macrocystis* kelp canopy productivity, version
#'   1.4.0, <https://doi.org/10.21966/k88j-1k50>.
#' @seealso [fit_weight_hakai_macro] for the fit to this dataset.
#' @family reference datasets
"data_weight_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis weight data
#'
#' Diameters and wet weights of plants harvested by the Hakai Institute in
#' British Columbia after day of year 140, measured at the maximum sub-bulb
#' diameter, one row per plant.
#'
#' @format A tibble with 1184 rows and columns:
#' \describe{
#'   \item{diameter_mm}{Maximum sub-bulb diameter (mm).}
#'   \item{weight_kg}{Wet weight (kg).}
#'   \item{site}{Site code, a factor (28 levels).}
#'   \item{year}{Harvest year, a factor (7 levels, 2019 to 2025).}
#' }
#' @source Hakai Institute, *Nereocystis* kelp canopy productivity, version
#'   1.3.0, <https://doi.org/10.21966/d1s2-s530>.
#' @seealso [fit_weight_hakai_nereo] for the fit to this dataset.
#' @family reference datasets
"data_weight_hakai_nereo"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Macrocystis wet/dry data
#'
#' Wet and dry masses of Hakai Institute tissue samples in British Columbia, all
#' months and tissues pooled, one row per tissue sample.
#'
#' @format A tibble with 215 rows and columns:
#' \describe{
#'   \item{wet_mass_g}{Wet mass of the sample (g).}
#'   \item{dry_mass_g}{Dry mass of the sample (g).}
#' }
#' @source Hakai Institute, *Macrocystis* kelp canopy productivity, version
#'   1.4.0, <https://doi.org/10.21966/k88j-1k50>.
#' @seealso [fit_wetdry_hakai_macro] for the fit to this dataset.
#' @family reference datasets
"data_wetdry_hakai_macro"

# Built by data-raw/data_hakai.R.
#' Hakai Institute Nereocystis wet/dry data
#'
#' Wet and dry masses of Hakai Institute tissue samples in British Columbia, all
#' months and tissues pooled, one row per tissue sample.
#'
#' @format A tibble with 323 rows and columns:
#' \describe{
#'   \item{wet_mass_g}{Wet mass of the sample (g).}
#'   \item{dry_mass_g}{Dry mass of the sample (g).}
#' }
#' @source Hakai Institute, *Macrocystis* kelp canopy productivity, version
#'   1.4.0, <https://doi.org/10.21966/k88j-1k50>.
#' @seealso [fit_wetdry_hakai_nereo] for the fit to this dataset.
#' @family reference datasets
"data_wetdry_hakai_nereo"
