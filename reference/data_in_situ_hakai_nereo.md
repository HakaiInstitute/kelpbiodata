# Hakai Institute Nereocystis in situ survey data

Hakai Institute in situ surveys in British Columbia, each paired with a
drone flight, one row per survey (one per site-year), including surveys
with no plants counted. Surveys in site-years whose plants were sized
only by cumulative blade length are excluded.

## Usage

``` r
data_in_situ_hakai_nereo
```

## Format

A tibble with 39 rows and columns:

- survey_id:

  Survey identifier (`"<site> <year>"`), a character string.

- site:

  Site code, a factor (6 levels).

- year:

  Year, a factor (7 levels, 2019 to 2025).

- survey_area_m2:

  Area of the transects surveyed (m²).

- plants:

  Plants counted, an integer.

- plot_area_m2:

  Plot polygon (m²).

- canopy_area_m2:

  Drone canopy within the plot (m²).

- canopy_tide_height_m:

  Tide height when the canopy was imaged (m).

## Source

Plants counted from Hakai Institute, *Nereocystis* kelp canopy
productivity, version 1.3.0, <https://doi.org/10.21966/d1s2-s530>.
Canopy for 2015 to 2024 from Hakai Institute, kelp drone mapping data,
version 1.0, <https://doi.org/10.21966/9cbv-ra30>. The 2025 canopy, the
plot polygons and the 2025 tide heights are unpublished.

## Attribution

The Hakai Institute data in this package were collected in collaboration
with the Heiltsuk Integrated Resource Management Department (HIRMD)
within Haíɫzaqv (Heiltsuk) territory. Any outputs using these data
should credit both the Hakai Institute and HIRMD. To learn more about
resource management or conducting research in Haíɫzaqv territory,
including on kelp forests, visit [hirmd.ca](https://hirmd.ca/).

Licensed under [CC BY
4.0](https://creativecommons.org/licenses/by/4.0/).

## See also

[fit_cover_calibration_hakai_nereo](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_cover_calibration_hakai_nereo.md),
calibrated to the biomass of these surveys.

Other reference datasets:
[`data_carbon_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_carbon_hakai_macro.md),
[`data_carbon_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_carbon_hakai_nereo.md),
[`data_in_situ_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_macro.md),
[`data_nitrogen_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_nitrogen_hakai_macro.md),
[`data_nitrogen_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_nitrogen_hakai_nereo.md),
[`data_size_census_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_size_census_hakai_macro.md),
[`data_size_sample_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_size_sample_hakai_nereo.md),
[`data_weight_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_weight_hakai_macro.md),
[`data_weight_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_weight_hakai_nereo.md),
[`data_wetdry_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_wetdry_hakai_macro.md),
[`data_wetdry_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_wetdry_hakai_nereo.md)
