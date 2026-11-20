# CLAUDE.md - kelpbiodata

R data package of Hakai Institute kelp survey datasets and reference fits made with kelpbio.
Code style and naming follow kelpbio (datasets `data_<model>_<source>_<species>`, fits `fit_<model>_<source>_<species>`, unit-suffixed columns); documentation follows `STYLE.md`.

## Workflow

- Work is committed to `dev`; a single pull request from `dev` to `main` collects it.
- Commit and push only when asked.
- Before pushing, run `Rscript scripts/build.R` and `jarl check .`, as CI runs R CMD check and jarl.

## Commands

| Task | Command |
|------|---------|
| Document and install | `Rscript scripts/build.R` |
| Also run R CMD check | `Rscript scripts/build.R --check` |
| Also build the pkgdown site | `Rscript scripts/build.R --site` |

## Layout

| Path | Contents |
|------|----------|
| `data-raw/data_hakai.R` | Builds the datasets from the Hakai Institute data packages (read from their release tags) and `data-raw/supplement/`, and writes them to `data/` and `data-raw/real/*.csv` |
| `data-raw/supplement_hakai.R` | Builds `data-raw/supplement/` (tissue isotopes and plot canopy summaries) from unpublished local files |
| `data-raw/site_key.R` | Replaces site names with codes from a private site key |
| `data-raw/fit_<model>_<source>_<species>.R` | One script per reference fit |
| `R/data.R`, `R/fits.R` | Documentation of the datasets and fits |

## Rules

- Site names are never written to any file in the repository; sites are identified only by code. The site key (`KELPBIODATA_SITE_KEY`) and the local files (`KELPBIODATA_LOCAL`) are kept outside the repository.
- Every object in `data/` is built by a script in `data-raw/`; never save objects from an interactive session.
- The fit scripts call the installed kelpbio as `kelpbio::`; kelpbio is not needed to load the fits. Record the kelpbio commit used when refitting.
- Refit a reference fit when kelpbio changes its model or the fit object, or when its CSV in `data-raw/real/` changes.
- Fitting is Stan MCMC and slow: confirm before running a fit script.
- Pre-release (`0.0.0.9000`): no NEWS entries or version bumps.
