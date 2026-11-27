# Hakai Institute Macrocystis size census data

Every plant with at least one frond at 1 m above the holdfast counted on
the density transects of the surveys in
[data_in_situ_hakai_macro](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_macro.md),
one row per plant.

## Usage

``` r
data_size_census_hakai_macro
```

## Format

A tibble with 2861 rows and columns:

- survey_id:

  Survey the plant was counted in, matching its `survey_id`.

- fronds:

  Fronds reaching 1 m above the holdfast, an integer.

- partial:

  Whether the plant is counted as half (on the edge of a transect), a
  logical.

## Source

Hakai Institute, *Macrocystis* kelp canopy productivity, version 1.4.0,
<https://doi.org/10.21966/k88j-1k50>.

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

[fit_cover_calibration_hakai_macro](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_cover_calibration_hakai_macro.md),
calibrated to the biomass of these surveys.

Other reference datasets:
[`data_carbon_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_carbon_hakai_macro.md),
[`data_carbon_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_carbon_hakai_nereo.md),
[`data_in_situ_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_macro.md),
[`data_in_situ_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_nereo.md),
[`data_nitrogen_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_nitrogen_hakai_macro.md),
[`data_nitrogen_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_nitrogen_hakai_nereo.md),
[`data_size_sample_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_size_sample_hakai_nereo.md),
[`data_weight_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_weight_hakai_macro.md),
[`data_weight_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_weight_hakai_nereo.md),
[`data_wetdry_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_wetdry_hakai_macro.md),
[`data_wetdry_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/data_wetdry_hakai_nereo.md)
