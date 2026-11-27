# Hakai Institute Macrocystis cover calibration fit

A fit of `kelpbio::kb_fit_cover_calibration_macro()` to Hakai Institute
in situ surveys in British Columbia, each paired with a drone flight,
for predicting canopy biomass with
`kelpbio::kb_predict_biomass_canopy()` without fitting a calibration.
Each survey's wet biomass per m² is predicted by
`kelpbio::kb_predict_biomass_in_situ()` from
[fit_weight_hakai_macro](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_macro.md)
and every plant counted on its transects with at least one frond at 1 m;
the plants of site `"HAK012"` take the weight effect of `"HAK042"`, one
of its two plots.

## Usage

``` r
fit_cover_calibration_hakai_macro
```

## Format

An object of class
`c("kb_fit_cover_calibration_macro", "kb_fit_cover_calibration", "kb_fit")`.
The data are in `fit$data`.

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

`kelpbio::kb_fit_cover_calibration_macro()`,
[data_in_situ_hakai_macro](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_macro.md)
for the surveys, and
[data_size_census_hakai_macro](https://hakaiinstitute.github.io/kelpbiodata/reference/data_size_census_hakai_macro.md)
for their plants.

Other reference fits:
[`fit_carbon_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_carbon_hakai_macro.md),
[`fit_carbon_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_carbon_hakai_nereo.md),
[`fit_cover_calibration_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_cover_calibration_hakai_nereo.md),
[`fit_nitrogen_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_nitrogen_hakai_macro.md),
[`fit_nitrogen_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_nitrogen_hakai_nereo.md),
[`fit_size_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_size_hakai_nereo.md),
[`fit_weight_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_macro.md),
[`fit_weight_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_nereo.md),
[`fit_wetdry_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_wetdry_hakai_macro.md),
[`fit_wetdry_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_wetdry_hakai_nereo.md)
