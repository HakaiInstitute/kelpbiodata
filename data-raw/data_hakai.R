# Builds the Hakai datasets in data/ and their CSVs in data-raw/real/ (diff
# these to see what a source update changed; refit any fit whose CSV changed).
#
# To add a year of data: bump the release tags below and max_year, rerun
# data-raw/supplement_hakai.R for the new canopy and isotopes, then run
#   KELPBIODATA_SITE_KEY=<csv> Rscript data-raw/data_hakai.R
#
# Sites are written as IDs from the private site key (see data-raw/site_key.R).

source("data-raw/site_key.R")

nereo_pkg <- list(
  repo = "Nereocystis_kelp_canopy_productivity",
  tag = "v1.3.0"
)
macro_pkg <- list(
  repo = "Macrocystis_kelp_canopy_productivity",
  tag = "macrov1.4.0"
)

# Last year both species' packages cover.
max_year <- 2025L

download_dir <- file.path(tempdir(), "hakai")

read_pkg <- function(pkg, file, ...) {
  path <- file.path(download_dir, pkg$repo, pkg$tag, file)
  if (!file.exists(path)) {
    dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
    url <- stringr::str_c(
      "https://raw.githubusercontent.com/HakaiInstitute",
      pkg$repo,
      pkg$tag,
      "data",
      file,
      sep = "/"
    )
    utils::download.file(url, path, mode = "wb", quiet = TRUE)
  }
  readr::read_csv(
    path,
    na = c("", "NA", "na"),
    show_col_types = FALSE,
    progress = FALSE,
    ...
  )
}

read_supplement <- function(file, ...) {
  readr::read_csv(
    file.path("data-raw/supplement", file),
    show_col_types = FALSE,
    progress = FALSE,
    ...
  )
}

year_of <- function(date) as.integer(format(date, "%Y"))
month_of <- function(date) as.integer(format(date, "%m"))

write_real <- function(data, name) {
  dir.create("data-raw/real", showWarnings = FALSE)
  readr::write_csv(data, file.path("data-raw/real", stringr::str_c(name, ".csv")))
}

drop_outliers <- function(data, weight, predictor) {
  fit <- stats::lm(
    stats::as.formula(stringr::str_glue(
      "log({weight}) ~ poly(log({predictor}), 2)"
    )),
    data = data
  )
  data[abs(stats::rstandard(fit)) <= 4, ]
}

# Nereocystis weight -----------------------------------------------------------

# The outlier screen uses all dates; early-season harvests are dropped after.
weight_hakai_nereo <- read_pkg(nereo_pkg, "nereo_harvest.csv") |>
  dplyr::filter(year_of(date) <= max_year) |>
  dplyr::mutate(weight = stipeW + bladeW) |>
  dplyr::filter(
    !is.na(Sbulb_max),
    Sbulb_max > 0,
    !is.na(weight),
    weight > 0
  ) |>
  drop_outliers("weight", "Sbulb_max") |>
  dplyr::filter(as.integer(format(date, "%j")) > 140) |>
  dplyr::transmute(
    diameter_mm = Sbulb_max,
    weight_kg = round(weight, 3),
    site = site_id(site),
    year = year_of(date)
  )

# Nereocystis size -------------------------------------------------------------

# Diameters <= 1 mm are placeholders. July and August only: the size model has
# no month effect.
size_only_nereo <- read_pkg(nereo_pkg, "nereo_size.csv")
size_tagged_nereo <- read_pkg(nereo_pkg, "metrics_long.csv") |>
  dplyr::filter(!is.na(Sbulb_max)) |>
  dplyr::select(dplyr::any_of(names(size_only_nereo)))

size_sample_hakai_nereo <- dplyr::bind_rows(
  size_only_nereo,
  size_tagged_nereo
) |>
  dplyr::mutate(date = as.Date(date)) |>
  dplyr::filter(
    year_of(date) <= max_year,
    !is.na(Sbulb_max),
    Sbulb_max > 1,
    month_of(date) %in% 7:8
  ) |>
  dplyr::transmute(
    diameter_mm = Sbulb_max,
    site = site_id(site),
    year = year_of(date)
  )

# Site-years sized only by cumulative blade length, which kelpbio cannot use;
# their surveys are dropped.
cbl_only_nereo <- read_pkg(nereo_pkg, "nereo_metrics.csv") |>
  dplyr::mutate(date = as.Date(date1), cbl = bladeL1 * Bcount2) |>
  dplyr::filter(year_of(date) <= max_year, !is.na(cbl), cbl > 0) |>
  dplyr::distinct(site = site_id(site), year = year_of(date)) |>
  dplyr::anti_join(size_sample_hakai_nereo, by = c("site", "year"))

# Wet/dry ----------------------------------------------------------------------

# Tray masses are in mg. Suspect wet masses are flagged by text in tray_wet or
# the comment "wrong wet weight?"; check new releases for other flags.
wetdry_hakai <- read_pkg(
  macro_pkg,
  "macro_wetdry.csv",
  col_types = readr::cols(tray_wet = readr::col_character())
) |>
  dplyr::mutate(
    tray_wet = dplyr::if_else(
      stringr::str_detect(tray_wet, "^-?[0-9]+(\\.[0-9]+)?$") &
        !stringr::str_detect(dplyr::coalesce(comments, ""), "wrong wet weight"),
      tray_wet,
      NA_character_
    ),
    wet_mass = as.numeric(tray_wet) - tray,
    dry_mass = tray_dry - tray,
    dry_ratio = dry_mass / wet_mass
  ) |>
  dplyr::filter(
    !is.na(wet_mass),
    !is.na(dry_mass),
    wet_mass > 0,
    dry_mass > 0,
    !stringr::str_detect(dplyr::coalesce(comments, ""), "griswold"),
    dry_ratio > 0.02,
    dry_ratio < 0.5
  )

reshape_wetdry <- function(data) {
  dplyr::transmute(
    data,
    wet_mass_g = round(wet_mass / 1000, 4),
    dry_mass_g = round(dry_mass / 1000, 4)
  )
}

wetdry_hakai_nereo <- wetdry_hakai |>
  dplyr::filter(species == "nereo") |>
  reshape_wetdry()

# Two 2016 batches with a suspected wet-weighing failure.
wetdry_hakai_macro <- wetdry_hakai |>
  dplyr::filter(species == "macro") |>
  dplyr::mutate(site = site_id(stringr::str_to_title(site))) |>
  dplyr::filter(
    !(site == "HAK036" & date == as.Date("2016-08-12")),
    !(site == "HAK040" & date == as.Date("2016-08-11"))
  ) |>
  reshape_wetdry()

# Carbon and nitrogen ----------------------------------------------------------

# Sample mass in mg, element mass in ug; implausible fractions are dropped.
isotopes_hakai <- read_supplement("isotopes_hakai.csv")

carbon_hakai <- function(taxon) {
  isotopes_hakai |>
    dplyr::filter(
      taxon_code == taxon,
      amount_C / (weight * 1000) > 0.10,
      amount_C / (weight * 1000) < 0.50
    ) |>
    dplyr::transmute(sample_mass_mg = weight, carbon_mass_ug = amount_C)
}

nitrogen_hakai <- function(taxon) {
  isotopes_hakai |>
    dplyr::filter(
      taxon_code == taxon,
      amount_N / (weight * 1000) > 0.002,
      amount_N / (weight * 1000) < 0.05
    ) |>
    dplyr::transmute(sample_mass_mg = weight, nitrogen_mass_ug = amount_N)
}

carbon_hakai_nereo <- carbon_hakai("NERL")
carbon_hakai_macro <- carbon_hakai("MACP")
nitrogen_hakai_nereo <- nitrogen_hakai("NERL")
nitrogen_hakai_macro <- nitrogen_hakai("MACP")

# Macrocystis weight -----------------------------------------------------------

# Weights are by whole frond before 2019 and by section from 2019. Rows noted
# "extra biomass for plant" add to the plant; "for the entire site" belong to
# no plant. 2014 plants were harvested at the surface only.
harvest_macro <- read_pkg(macro_pkg, "macro_harvest.csv") |>
  dplyr::filter(year_of(date) != 2014) |>
  dplyr::mutate(
    extra_plant = stringr::str_detect(
      dplyr::coalesce(Notes, ""),
      stringr::regex("extra biomass for plant", ignore_case = TRUE)
    ),
    extra_site = stringr::str_detect(
      dplyr::coalesce(Notes, ""),
      stringr::regex("extra biomass for the entire site", ignore_case = TRUE)
    )
  )

plant_fronds_macro <- harvest_macro |>
  dplyr::filter(!extra_plant, !extra_site) |>
  dplyr::mutate(
    biomass = dplyr::coalesce(frond_weight, 0) +
      dplyr::coalesce(section_weight, 0)
  ) |>
  dplyr::filter(biomass > 0) |>
  dplyr::summarise(
    fronds = dplyr::n_distinct(frond),
    weight_fronds = sum(biomass),
    .by = c(site, date, tag)
  )

plant_extra_macro <- harvest_macro |>
  dplyr::filter(extra_plant, !is.na(frond_weight)) |>
  dplyr::summarise(weight_extra = sum(frond_weight), .by = c(site, date, tag))

weight_hakai_macro <- plant_fronds_macro |>
  dplyr::left_join(plant_extra_macro, by = c("site", "date", "tag")) |>
  dplyr::mutate(
    weight = weight_fronds + dplyr::coalesce(weight_extra, 0)
  ) |>
  dplyr::filter(fronds >= 1, weight > 0) |>
  dplyr::arrange(site, date, tag) |>
  drop_outliers("weight", "fronds") |>
  dplyr::transmute(
    fronds = as.integer(fronds),
    weight_kg = round(weight, 3),
    site = site_id(site),
    year = year_of(date)
  )

# In situ surveys --------------------------------------------------------------

# Pairs each canopy map with the nearest in situ survey within 21 days.
pair_dives <- function(species, dives) {
  read_supplement("plot_canopy_hakai.csv") |>
    dplyr::filter(species == .env$species) |>
    dplyr::inner_join(
      dives,
      by = c("site", "year"),
      relationship = "many-to-many"
    ) |>
    dplyr::mutate(lag_days = as.numeric(date_dive - date_drone)) |>
    dplyr::slice_min(
      abs(lag_days),
      n = 1,
      with_ties = FALSE,
      by = c(site, year, month)
    ) |>
    dplyr::filter(abs(lag_days) <= 21) |>
    dplyr::arrange(site, year)
}

dives_nereo <- read_pkg(nereo_pkg, "nereo_density.csv") |>
  dplyr::filter(year_of(date) <= max_year) |>
  dplyr::summarise(
    plants = sum(stipeD, na.rm = TRUE),
    survey_area_m2 = sum(area, na.rm = TRUE),
    .by = c(site, date)
  ) |>
  dplyr::transmute(
    site = site_id(site),
    year = year_of(date),
    date_dive = date,
    plants,
    survey_area_m2
  ) |>
  dplyr::arrange(site, year, date_dive)

survey_hakai_nereo <- pair_dives("nereo", dives_nereo) |>
  dplyr::anti_join(cbl_only_nereo, by = c("site", "year")) |>
  dplyr::transmute(
    survey_id = stringr::str_c(site, year, sep = " "),
    site,
    year,
    survey_area_m2,
    plants = as.integer(plants),
    plot_area_m2,
    canopy_area_m2,
    canopy_tide_height_m = tide_height_m
  )
stopifnot(!anyDuplicated(survey_hakai_nereo$survey_id))

# Fractional transects are 2018 extra lines, dropped on Hakai's instruction.
density_macro <- read_pkg(macro_pkg, "macro_density.csv") |>
  dplyr::mutate(
    date = if (all(is.na(date))) date else dplyr::coalesce(date, min(date, na.rm = TRUE)),
    .by = c(period, site, transect, side)
  ) |>
  dplyr::filter(
    year_of(date) <= max_year,
    transect %% 1 == 0,
    !is.na(transect_length)
  ) |>
  dplyr::mutate(site = site_id(site))
stopifnot(!anyNA(density_macro$date))

# Edge plants (C_P_T "P") count half; transects are 2 m wide.
transects_macro <- density_macro |>
  dplyr::mutate(
    plant = dplyr::case_when(
      is.na(fronds_1m) | fronds_1m == 0 ~ 0,
      C_P_T %in% "P" ~ 0.5,
      .default = 1
    )
  ) |>
  dplyr::summarise(
    plants = round(sum(plant)),
    area = dplyr::first(transect_length) * 2,
    .by = c(site, date, transect)
  )

dives_macro <- transects_macro |>
  dplyr::summarise(
    plants = sum(plants),
    lines = dplyr::n(),
    survey_area_m2 = sum(area),
    .by = c(site, date)
  ) |>
  dplyr::transmute(
    site,
    year = year_of(date),
    date_dive = date,
    plants,
    lines,
    survey_area_m2
  ) |>
  dplyr::arrange(site, year, date_dive)

# Plots HAK011 and HAK042 share one canopy map, so they are one site, HAK012,
# with two surveys a year, each identified by its plot.
survey_hakai_macro <- pair_dives("macro", dives_macro) |>
  dplyr::transmute(
    survey_id = stringr::str_c(site, year, sep = " "),
    plot = site,
    site = dplyr::if_else(
      site %in% c("HAK011", "HAK042"),
      "HAK012",
      site
    ),
    year,
    survey_area_m2,
    plot_area_m2,
    canopy_area_m2,
    canopy_tide_height_m = tide_height_m,
    date_dive,
    plants,
    lines
  )
stopifnot(!anyDuplicated(survey_hakai_macro$survey_id))

size_census_hakai_macro <- density_macro |>
  dplyr::filter(!is.na(fronds_1m), fronds_1m >= 1) |>
  dplyr::semi_join(transects_macro, by = c("site", "date", "transect")) |>
  dplyr::inner_join(
    dplyr::select(survey_hakai_macro, survey_id, site = plot, date = date_dive),
    by = c("site", "date")
  ) |>
  dplyr::transmute(
    survey_id,
    fronds = as.integer(fronds_1m),
    partial = C_P_T %in% "P"
  )

# The census must match each survey's count, up to per-transect rounding.
census_check_macro <- size_census_hakai_macro |>
  dplyr::summarise(
    census = sum(dplyr::if_else(partial, 0.5, 1)),
    .by = survey_id
  ) |>
  dplyr::right_join(survey_hakai_macro, by = "survey_id")
stopifnot(
  !anyNA(census_check_macro$census),
  abs(census_check_macro$census - census_check_macro$plants) <=
    0.5 * census_check_macro$lines
)

survey_hakai_macro <- dplyr::select(
  survey_hakai_macro,
  -plot,
  -date_dive,
  -plants,
  -lines
)

# Export -----------------------------------------------------------------------

as_reference <- function(data) {
  dplyr::mutate(data, dplyr::across(dplyr::any_of(c("site", "year")), factor))
}

data_weight_hakai_nereo <- as_reference(weight_hakai_nereo)
data_weight_hakai_macro <- as_reference(weight_hakai_macro)
data_size_sample_hakai_nereo <- as_reference(size_sample_hakai_nereo)
data_size_census_hakai_macro <- size_census_hakai_macro
data_in_situ_hakai_nereo <- as_reference(survey_hakai_nereo)
data_in_situ_hakai_macro <- as_reference(survey_hakai_macro)
data_wetdry_hakai_nereo <- wetdry_hakai_nereo
data_wetdry_hakai_macro <- wetdry_hakai_macro
data_carbon_hakai_nereo <- carbon_hakai_nereo
data_carbon_hakai_macro <- carbon_hakai_macro
data_nitrogen_hakai_nereo <- nitrogen_hakai_nereo
data_nitrogen_hakai_macro <- nitrogen_hakai_macro

write_real(data_weight_hakai_nereo, "weight_hakai_nereo")
write_real(data_weight_hakai_macro, "weight_hakai_macro")
write_real(data_size_sample_hakai_nereo, "size_sample_hakai_nereo")
write_real(data_size_census_hakai_macro, "size_census_hakai_macro")
write_real(data_in_situ_hakai_nereo, "in_situ_hakai_nereo")
write_real(data_in_situ_hakai_macro, "in_situ_hakai_macro")
write_real(data_wetdry_hakai_nereo, "wetdry_hakai_nereo")
write_real(data_wetdry_hakai_macro, "wetdry_hakai_macro")
write_real(data_carbon_hakai_nereo, "carbon_hakai_nereo")
write_real(data_carbon_hakai_macro, "carbon_hakai_macro")
write_real(data_nitrogen_hakai_nereo, "nitrogen_hakai_nereo")
write_real(data_nitrogen_hakai_macro, "nitrogen_hakai_macro")

usethis::use_data(
  data_weight_hakai_nereo,
  data_weight_hakai_macro,
  data_size_sample_hakai_nereo,
  data_size_census_hakai_macro,
  data_in_situ_hakai_nereo,
  data_in_situ_hakai_macro,
  data_wetdry_hakai_nereo,
  data_wetdry_hakai_macro,
  data_carbon_hakai_nereo,
  data_carbon_hakai_macro,
  data_nitrogen_hakai_nereo,
  data_nitrogen_hakai_macro,
  overwrite = TRUE
)
