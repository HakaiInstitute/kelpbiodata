
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kelpbiodata

<!-- badges: start -->

[![R-CMD-check](https://github.com/HakaiInstitute/kelpbiodata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/HakaiInstitute/kelpbiodata/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

kelpbiodata holds field survey datasets for *Nereocystis luetkeana* and
*Macrocystis pyrifera* from the Hakai Institute in British Columbia, and
reference models fitted to them with the
[kelpbio](https://github.com/HakaiInstitute/kelpbio) package. See the
kelpbio documentation for the models and how to use the fits. Sites are
identified by code (`HAK001`, …).

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

Rows with the same site are the same site: a new year of data at a
reference site, under its code, shares its site effect. A prefix, as in
`"MyProgramme:Cove"`, keeps new sites apart from the reference sites.

## Attribution

The Hakai Institute data in this package were collected in collaboration
with the Heiltsuk First Nation on Heiltsuk territory. Please credit the
Heiltsuk Integrated Resource Management Department and the Hakai
Institute in any outputs that use these data. The statement is also
returned by `kelpbiodata_attribution()`.

## Citation

If you use kelpbiodata in your work, please cite it and the Hakai
Institute data packages its datasets are built from. Use `citation()` to
get formatted citations and BibTeX entries:

``` r
citation("kelpbiodata")
#> To cite kelpbiodata in publications, cite the package and the data
#> packages its datasets are built from:
#> 
#>   Dalgarno S (2026). _kelpbiodata: Kelp Biomass Data and Reference
#>   Model Fits for 'kelpbio'_. R package version 0.0.0.9000,
#>   <https://github.com/HakaiInstitute/kelpbiodata>.
#> 
#>   Pontier O, Burt J, Okamoto D, Hessing-Lewis M (2026). "Nereocystis
#>   kelp canopy productivity data from BC Central Coast." Hakai Institute
#>   dataset. doi:10.21966/d1s2-s530 <https://doi.org/10.21966/d1s2-s530>.
#>   Version 1.3.0.
#> 
#>   Pontier O, Krumhansl K, Hessing-Lewis M (2026). "Macrocystis kelp
#>   canopy productivity data from BC Central Coast." Hakai Institute
#>   dataset. doi:10.21966/k88j-1k50 <https://doi.org/10.21966/k88j-1k50>.
#>   Version 1.4.0.
#> 
#>   Reshitnyk L, Holmes K (2025). "Time series of surface kelp canopy
#>   area derived from remotely piloted aerial systems (RPAS, or drone)
#>   surveys, Central Coast, British Columbia." Hakai Institute dataset.
#>   doi:10.21966/9cbv-ra30 <https://doi.org/10.21966/9cbv-ra30>. Version
#>   1.0.
#> 
#> The Hakai Institute data in this package were collected in
#> collaboration with the Heiltsuk First Nation on Heiltsuk territory.
#> Please credit the Heiltsuk Integrated Resource Management Department
#> and the Hakai Institute in any outputs that use these data.
#> 
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

## Licensing

Copyright 2026 Tula Foundation.

The code and data are released under the [MIT License](LICENSE.md).
