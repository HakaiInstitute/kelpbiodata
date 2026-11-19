
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kelpbiodata

<!-- badges: start -->

[![R-CMD-check](https://github.com/HakaiInstitute/kelpbiodata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/HakaiInstitute/kelpbiodata/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

kelpbiodata holds field survey datasets for *Nereocystis luetkeana* and
*Macrocystis pyrifera*, and reference models fitted to them with the
[kelpbio](https://github.com/HakaiInstitute/kelpbio) package. See the
kelpbio documentation for the models and how to use the fits.

## Installation

Install from GitHub:

``` r
# install.packages("pak")
pak::pak("HakaiInstitute/kelpbiodata")
```

## Adding new data to a reference dataset

The data behind each reference fit are exported as
`data_<sheet>_<source>_<species>`, with the columns and column types of
kelpbio’s simulated datasets, so new data can be appended with
`dplyr::bind_rows()` and the combined data fitted with the kelpbio
function for that model. `site` and `year` are factors, and bind to
factor or character columns.

``` r
new <- data.frame(
  diameter_mm = c(31, 44, 27),
  weight_kg = c(1.2, 3.1, 0.8),
  site = "MyProgramme:Cove",
  year = "2026"
)
data <- dplyr::bind_rows(kelpbiodata::data_weight_hakai_nereo, new)
fit <- kelpbio::kb_fit_weight_nereo(data)
```

Rows with the same site name are the same site: a new year of data at a
reference site shares its site effect. Sites that only share a name with
a reference site need a prefix, as in `"MyProgramme:Cove"`.
