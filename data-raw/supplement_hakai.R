# Build the supplementary Hakai Institute inputs that have no published data
# package, from local files, and write them to data-raw/supplement/, where
# data-raw/data_hakai.R reads them. Run only when those inputs change:
#
#   KELPBIODATA_LOCAL=<dir> KELPBIODATA_SITE_KEY=<csv> \
#     Rscript data-raw/supplement_hakai.R
#
# KELPBIODATA_LOCAL is the directory of the unpublished Hakai Institute files;
# KELPBIODATA_SITE_KEY is the private site key (see data-raw/site_key.R).
# Requires GDAL's ogr2ogr on the PATH and the sf package.
#
# Writes:
#
# - isotopes_hakai.csv: the carbon and nitrogen of each kelp tissue sample
#   (kelp_isotopes.csv), trimmed to the columns the build uses.
# - plot_canopy_hakai.csv: one row per canopy map (site and flight date) and
#   species with the area of the survey plot, the canopy of that species
#   inside it and the tide height at the flight. The plot polygons are not published, so only these
#   summaries are kept; no coordinates are written.
#
# The canopy is from the drone package (kelp-drone-mapping-data v1.0,
# doi:10.21966/9cbv-ra30) for 2015 to 2024 and from the per-site 2025
# shapefiles in KELPBIODATA_LOCAL.

local_dir <- Sys.getenv("KELPBIODATA_LOCAL")
if (!nzchar(local_dir) || !dir.exists(local_dir)) {
  stop(
    "Set KELPBIODATA_LOCAL to the directory of the unpublished Hakai Institute files.",
    call. = FALSE
  )
}
ogr2ogr <- Sys.which("ogr2ogr")
if (!nzchar(ogr2ogr)) {
  stop("ogr2ogr not found on the PATH; install GDAL.", call. = FALSE)
}

source("data-raw/site_key.R")

out_dir <- "data-raw/supplement"
dir.create(out_dir, showWarnings = FALSE)

# Isotopes ---------------------------------------------------------------------

readr::read_csv(file.path(local_dir, "kelp_isotopes.csv"), na = c("", "NA")) |>
  dplyr::filter(taxon_code %in% c("NERL", "MACP")) |>
  dplyr::select(
    UID,
    taxon_code,
    date_collected,
    weight,
    amount_C,
    amount_N
  ) |>
  readr::write_csv(file.path(out_dir, "isotopes_hakai.csv"))

# Drone package ----------------------------------------------------------------

drone_url <- stringr::str_c(
  "https://raw.githubusercontent.com/HakaiInstitute/kelp-drone-mapping-data/",
  "v1.0/data/CentralCoast_SeasonalDroneKelpPolygons.gdb.zip"
)
drone_dir <- file.path(tempdir(), "kelp-drone-mapping-data")
dir.create(drone_dir, showWarnings = FALSE)
drone_zip <- file.path(drone_dir, basename(drone_url))
utils::download.file(drone_url, drone_zip, mode = "wb", quiet = TRUE)
utils::unzip(drone_zip, exdir = drone_dir)
gdb <- file.path(drone_dir, "CentralCoast_SeasonalDroneKelpPolygons.gdb")

# sf's GDAL fails to read the canopy layer of the geodatabase, while ogr2ogr
# reads it, so both layers are converted to GeoPackages first.
convert_layer <- function(layer) {
  gpkg <- file.path(drone_dir, stringr::str_c(layer, ".gpkg"))
  args <- c(
    "-f", "GPKG", "-overwrite", gpkg, gdb, layer,
    "-nlt", "CONVERT_TO_LINEAR", "-dim", "XY"
  )
  status <- system2(ogr2ogr, shQuote(args))
  if (status != 0) stop("ogr2ogr failed on layer ", layer, call. = FALSE)
  gpkg
}

canopy_gpkg <- convert_layer("CentralCoast_DroneKelpPolygons_Seasonal_2015_2024")
aoi_gpkg <- convert_layer("Hakai_Drone_AOIs")

# Species is spelled inconsistently in the geodatabase ("Nerecystis",
# "Macrycystis", genus only, leading spaces); the first three letters resolve
# every value.
species_levels <- c("Macrocystis pyrifera", "Nereocystis luetkeana", "Mixed")
clean_species <- function(x) {
  x <- stringr::str_to_lower(stringr::str_trim(x))
  factor(
    dplyr::case_when(
      stringr::str_starts(x, "mac") ~ "Macrocystis pyrifera",
      stringr::str_starts(x, "ner") ~ "Nereocystis luetkeana",
      stringr::str_detect(x, "mix") ~ "Mixed"
    ),
    levels = species_levels
  )
}

# The geometry column is "geom" in a GeoPackage and "geometry" in a shapefile.
name_geometry <- function(x) {
  names(x)[names(x) == attr(x, "sf_column")] <- "geometry"
  sf::st_geometry(x) <- "geometry"
  x
}

as_polygons <- function(x) {
  x |>
    sf::st_zm() |>
    sf::st_make_valid() |>
    sf::st_collection_extract("POLYGON") |>
    sf::st_cast("POLYGON", warn = FALSE)
}

canopy_drone <- sf::st_read(canopy_gpkg, quiet = TRUE)

canopy_drone <- canopy_drone |>
  dplyr::transmute(
    species = clean_species(ke_species),
    date_drone = as.Date(img_date),
    year = as.integer(format(date_drone, "%Y"))
  ) |>
  as_polygons() |>
  name_geometry()

# The 2025 canopy is delivered per site as "YYYYMMDD_Region_Site_rgb_kelp"
# shapefiles, which carry no provenance fields: the flight date comes from the
# file name, and the site from the plot the canopy falls in. A missing species
# label (5 features at site HAK040) is recovered from the classification
# code it is derived from (2 Macrocystis, 3 Nereocystis), spelled "value",
# "Value" or "gridcode". The .prj files of some carry a spurious vertical CRS,
# so the CRS is set (NAD83(CSRS) / UTM 9N) rather than read.
read_canopy_2025 <- function(file) {
  date <- as.Date(stringr::str_sub(basename(file), 1, 8), format = "%Y%m%d")
  x <- sf::st_read(file, quiet = TRUE)
  code_col <- names(x)[stringr::str_to_lower(names(x)) %in% c("value", "gridcode")][1]
  coded <- factor(
    dplyr::case_when(x[[code_col]] == 2 ~ species_levels[1],
      x[[code_col]] == 3 ~ species_levels[2]
    ),
    levels = species_levels
  )
  labelled <- clean_species(x$species)
  stopifnot(all(labelled == coded, na.rm = TRUE))
  x |>
    dplyr::transmute(
      species = dplyr::coalesce(labelled, coded),
      date_drone = date,
      year = as.integer(format(date, "%Y"))
    ) |>
    sf::st_zm() |>
    sf::st_set_crs(3156) |>
    sf::st_transform(sf::st_crs(canopy_drone)) |>
    as_polygons() |>
    name_geometry()
}

canopy_2025 <- list.files(
  file.path(local_dir, "percent-cover/spatial/2025_site_data"),
  pattern = "\\.shp$",
  full.names = TRUE
) |>
  lapply(read_canopy_2025) |>
  do.call(what = rbind)

canopy <- rbind(canopy_drone, canopy_2025)
stopifnot(!anyNA(canopy$species))
canopy <- canopy[!sf::st_is_empty(canopy), ]

# Survey plots: the site is the file name up to "_plot".
plots <- list.files(
  file.path(local_dir, "percent-cover/spatial/polygon-transect"),
  pattern = "_plot\\.shp$",
  recursive = TRUE,
  full.names = TRUE,
  ignore.case = TRUE
) |>
  lapply(function(file) {
    stem <- stringr::str_remove(
      tools::file_path_sans_ext(basename(file)),
      stringr::regex("_plot.*$", ignore_case = TRUE)
    )
    sf::st_read(file, quiet = TRUE) |>
      sf::st_zm() |>
      sf::st_transform(sf::st_crs(canopy)) |>
      sf::st_make_valid() |>
      dplyr::transmute(site = site_id(stem))
  }) |>
  do.call(what = rbind)

aois <- sf::st_read(aoi_gpkg, quiet = TRUE) |>
  sf::st_zm() |>
  sf::st_transform(sf::st_crs(canopy)) |>
  sf::st_make_valid()

# Drone surveys ----------------------------------------------------------------

# The management sheet lists every flight with its tide height. The drone
# package records the tide too, but as the raw flight log ("<2", "0.2-0.3"),
# which the sheet resolves to a number ("<2 m" is 1.1), so the sheet is used
# for every year. Kept: RGB
# imagery classified other than by hand, with a date, at sites other than the
# Heiltsuk monitoring stations (which have no plot polygons), and with a tide
# height. The sheet mixes padded and unpadded dates.
surveys <- readr::read_csv(
  file.path(
    local_dir,
    "percent-cover/raw/Kelp_Drone_Project_Management_Sheet - Site_level_data.csv"
  ),
  col_types = readr::cols(.default = readr::col_character())
) |>
  dplyr::rename(site = 1) |>
  dplyr::filter(
    sensor_type %in% "RGB",
    !classification_method %in% "manual"
  ) |>
  dplyr::transmute(
    site = site_id(site),
    date_drone = as.Date(date, format = "%Y-%m-%d"),
    year = as.integer(format(date_drone, "%Y")),
    month,
    tide_sheet_m = as.numeric(tide_height_m)
  ) |>
  dplyr::filter(!stringr::str_starts(site, "HEI"), !is.na(date_drone), !is.na(month))
stopifnot(
  !anyDuplicated(surveys[c("site", "date_drone")]),
  !anyDuplicated(surveys[c("site", "year", "month")])
)

surveys <- surveys |>
  dplyr::rename(tide_height_m = tide_sheet_m) |>
  dplyr::filter(!is.na(tide_height_m))

# A canopy map takes the tide of the sheet row for its site and flight date.
# Where the sheet dates the flight differently from the canopy (HAK028 and
# HAK040 2018, HAK033 2019), the map takes the tide of the sheet's otherwise
# unmatched row for the same site, year, and month. The drone package's own
# tide for these flights agrees with the sheet, so the sheet dates are the error.
add_tide <- function(maps) {
  by_date <- dplyr::inner_join(
    maps,
    dplyr::select(surveys, site, date_drone, tide_height_m),
    by = c("site", "date_drone")
  )
  by_month <- maps |>
    dplyr::anti_join(by_date, by = c("site", "date_drone")) |>
    dplyr::mutate(month = month.abb[as.integer(format(date_drone, "%m"))]) |>
    dplyr::inner_join(
      surveys |>
        dplyr::anti_join(maps, by = c("site", "date_drone")) |>
        dplyr::select(site, year, month, tide_height_m),
      by = c("site", "year", "month")
    ) |>
    dplyr::select(-month)
  if (nrow(by_month) > 0) {
    message(
      "Tide by site and month, not date: ",
      stringr::str_flatten_comma(
        unique(stringr::str_c(by_month$site, " ", by_month$date_drone))
      )
    )
  }
  dplyr::bind_rows(by_date, by_month)
}

# Plot canopy ------------------------------------------------------------------

# The canopy of a species inside each plot, per canopy map (flight date). A map
# enters only if the drone mapped canopy of the species in the drone footprint
# (AOI) holding the plot; it then has zero canopy in the plot if none falls
# inside it.
plot_canopy <- function(species, plots) {
  # Plot and canopy attributes apply to every part of a geometry, so sf can
  # carry them through intersections without warning.
  plots <- sf::st_set_agr(plots, "constant")
  canopy_sp <- canopy[canopy$species == species, ] |>
    sf::st_set_agr("constant")

  in_plot <- sf::st_intersection(plots, canopy_sp)
  in_plot$area <- as.numeric(sf::st_area(in_plot))
  in_plot <- in_plot |>
    sf::st_drop_geometry() |>
    dplyr::summarise(
      canopy_area_m2 = sum(area),
      .by = c(site, year, date_drone)
    )

  plot_points <- sf::st_point_on_surface(plots)
  footprints <- sf::st_join(aois, plot_points, left = FALSE) |>
    dplyr::select(site) |>
    sf::st_set_agr("constant")
  in_footprint <- sf::st_intersection(footprints, canopy_sp) |>
    sf::st_drop_geometry() |>
    dplyr::distinct(site, year, date_drone)

  plot_area <- plots |>
    dplyr::mutate(plot_area_m2 = as.numeric(sf::st_area(plots))) |>
    sf::st_drop_geometry()

  in_footprint |>
    dplyr::left_join(in_plot, by = c("site", "year", "date_drone")) |>
    dplyr::mutate(canopy_area_m2 = dplyr::coalesce(canopy_area_m2, 0)) |>
    dplyr::inner_join(plot_area, by = "site") |>
    add_tide()
}

# HAK042 is a Macrocystis plot and is left out for Nereocystis.
# "Mixed" canopy belongs to neither species.
plot_canopy_hakai <- dplyr::bind_rows(
  nereo = plot_canopy("Nereocystis luetkeana", dplyr::filter(plots, site != "HAK042")),
  macro = plot_canopy("Macrocystis pyrifera", plots),
  .id = "species"
) |>
  dplyr::filter(plot_area_m2 > 0) |>
  dplyr::mutate(dplyr::across(c(plot_area_m2, canopy_area_m2), \(x) round(x, 2))) |>
  dplyr::select(
    species,
    site,
    year,
    date_drone,
    tide_height_m,
    plot_area_m2,
    canopy_area_m2
  ) |>
  dplyr::arrange(species, site, date_drone)
stopifnot(!anyDuplicated(plot_canopy_hakai[c("species", "site", "date_drone")]))

readr::write_csv(plot_canopy_hakai, file.path(out_dir, "plot_canopy_hakai.csv"))
