# Hakai Institute Nereocystis cover calibration fit

A fit of `kelpbio::kb_fit_cover_calibration_nereo()` to Hakai Institute
in situ surveys in British Columbia, each paired with a drone flight,
for predicting canopy biomass with
`kelpbio::kb_predict_biomass_canopy()` without fitting a calibration.
Each survey's wet biomass per m² is predicted by
`kelpbio::kb_predict_biomass_in_situ()` from
[fit_weight_hakai_nereo](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_nereo.md)
and
[fit_size_hakai_nereo](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_size_hakai_nereo.md).
Surveys with no plants counted are included. Surveys in site-years whose
plants were sized only by cumulative blade length are excluded.

## Usage

``` r
fit_cover_calibration_hakai_nereo
```

## Format

An object of class
`c("kb_fit_cover_calibration_nereo", "kb_fit_cover_calibration", "kb_fit")`.
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

`kelpbio::kb_fit_cover_calibration_nereo()` and
[data_in_situ_hakai_nereo](https://hakaiinstitute.github.io/kelpbiodata/reference/data_in_situ_hakai_nereo.md)
for the surveys.

Other reference fits:
[`fit_carbon_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_carbon_hakai_macro.md),
[`fit_carbon_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_carbon_hakai_nereo.md),
[`fit_cover_calibration_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_cover_calibration_hakai_macro.md),
[`fit_nitrogen_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_nitrogen_hakai_macro.md),
[`fit_nitrogen_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_nitrogen_hakai_nereo.md),
[`fit_size_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_size_hakai_nereo.md),
[`fit_weight_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_macro.md),
[`fit_weight_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_weight_hakai_nereo.md),
[`fit_wetdry_hakai_macro`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_wetdry_hakai_macro.md),
[`fit_wetdry_hakai_nereo`](https://hakaiinstitute.github.io/kelpbiodata/reference/fit_wetdry_hakai_nereo.md)
