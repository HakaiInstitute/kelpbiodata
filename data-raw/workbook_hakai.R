# Writes the Hakai Institute data as kelpbioshiny workbooks, one per species,
# with the real site names, for the Hakai Institute to upload to the app. The
# workbooks hold site names, so they are written outside the repository and
# never committed:
#
#   KELPBIODATA_SITE_KEY=<csv> KELPBIODATA_WORKBOOKS=<dir> \
#     Rscript data-raw/workbook_hakai.R
#
# Each workbook has the app's sheets (weight, size_sample or size_census,
# survey_in_situ, survey_canopy, wetdry, carbon, and nitrogen), built from the
# datasets in data/ and data-raw/supplement/site_canopy_hakai.csv. A site code
# is written as the first spelling of its site in the key.

source("data-raw/site_key.R")

out_dir <- Sys.getenv("KELPBIODATA_WORKBOOKS")
if (!nzchar(out_dir) || !dir.exists(out_dir)) {
  stop("Set KELPBIODATA_WORKBOOKS to an existing directory.", call. = FALSE)
}
if (startsWith(normalizePath(out_dir), normalizePath("."))) {
  stop("KELPBIODATA_WORKBOOKS must be outside the repository.", call. = FALSE)
}

site_names <- read_site_key() |>
  dplyr::distinct(site_id, .keep_all = TRUE)

site_name <- function(code) {
  name <- site_names$site[match(as.character(code), site_names$site_id)]
  stopifnot(!anyNA(name))
  name
}

# Survey ids are "<code> <year>".
survey_name <- function(id) {
  code <- stringr::str_extract(id, "^\\S+")
  stringr::str_c(site_name(code), stringr::str_remove(id, "^\\S+"))
}

load_data <- function(name) {
  env <- new.env()
  load(file.path("data", stringr::str_c(name, ".rda")), envir = env)
  data <- tibble::as_tibble(env[[name]])
  data <- dplyr::mutate(data, dplyr::across(dplyr::where(is.factor), as.character))
  if ("site" %in% names(data)) data$site <- site_name(data$site)
  if ("survey_id" %in% names(data)) data$survey_id <- survey_name(data$survey_id)
  if ("year" %in% names(data)) data$year <- as.integer(data$year)
  data
}

site_canopy <- readr::read_csv(
  "data-raw/supplement/site_canopy_hakai.csv",
  show_col_types = FALSE,
  progress = FALSE
)

survey_canopy <- function(species) {
  site_canopy |>
    dplyr::filter(species == .env$species) |>
    dplyr::transmute(
      site = site_name(site),
      year = as.integer(year),
      canopy_area_m2,
      canopy_tide_height_m = tide_height_m,
      classified_area_m2
    )
}

workbooks <- list(
  nereo = list(
    weight = load_data("data_weight_hakai_nereo"),
    size_sample = load_data("data_size_sample_hakai_nereo"),
    survey_in_situ = load_data("data_in_situ_hakai_nereo"),
    survey_canopy = survey_canopy("nereo"),
    wetdry = load_data("data_wetdry_hakai_nereo"),
    carbon = load_data("data_carbon_hakai_nereo"),
    nitrogen = load_data("data_nitrogen_hakai_nereo")
  ),
  macro = list(
    weight = load_data("data_weight_hakai_macro"),
    size_census = load_data("data_size_census_hakai_macro"),
    survey_in_situ = load_data("data_in_situ_hakai_macro"),
    survey_canopy = survey_canopy("macro"),
    wetdry = load_data("data_wetdry_hakai_macro"),
    carbon = load_data("data_carbon_hakai_macro"),
    nitrogen = load_data("data_nitrogen_hakai_macro")
  )
)

for (species in names(workbooks)) {
  writexl::write_xlsx(
    workbooks[[species]],
    file.path(out_dir, stringr::str_c("hakai-", species, ".xlsx"))
  )
}
