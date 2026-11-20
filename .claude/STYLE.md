# kelpbiodata documentation style

How kelpbiodata's reader-facing text is written: the roxygen of the reference fits and datasets (`R/fits.R`), DESCRIPTION, and README. kelpbio's `STYLE.md` applies in full: its principles, vocabulary, and mechanics. This file adds the templates for this package's topics.

## Templates

- **Reference fit**: title "<Source> <Genus> <topic> fit" ("Hakai Institute Macrocystis carbon fit"); description "A fit of `kelpbio::kb_fit_<topic>_<sp>()` to <the data: who collected them, where, what is pooled>, for <its use>.", in one or two sentences; `@format` "An object of class `c("kb_fit_<topic>_<sp>", "kb_fit_<topic>", "kb_fit")`. The data are in `fit$data`.", naming any extra data columns; `@seealso` the kelpbio fit function and any sibling fit; `@family reference fits`. A plain comment above the roxygen names the script that builds it ("# Built by data-raw/fit_<model>_<source>_<species>.R.").
- **Real dataset**: kelpbio's Dataset template, with the source in place of "Simulated" ("Hakai Institute Nereocystis weight data").

## Mechanics

- kelpbio functions are written `kelpbio::fun()` in code font, not linked, as kelpbio is not a dependency.
- A source is named as in the fit names: "Hakai Institute".
