# CLAUDE.md - kelpbiodata

R data package for kelpbio (Bayesian kelp biomass estimation). It holds real field survey datasets and reference fits made with kelpbio; kelpbio itself bundles only simulated data and small pre-fits for examples and tests.

Writing and documentation follow `STYLE.md`. Follow the kelpbio `CLAUDE.md` (`~/Code/HakaiInstitute/kelpbio/.claude/CLAUDE.md`) for code style and naming conventions (dataset names `data_<model>_<source>_<species>`, fit names `fit_<model>_<source>_<species>`, unit-suffixed columns); this file lists only what differs or is specific to the data package.

## Repositories and issues

- Development (branches, commits, pull requests) happens in the HakaiInstitute repo (`HakaiInstitute/kelpbiodata`), never in the poissonconsulting fork.
- GitHub issues go in the poissonconsulting fork (`poissonconsulting/kelpbiodata`), not the HakaiInstitute repo, to keep them out of the client's repo. The fork is public, so its issues are still publicly visible: write nothing in them that should stay internal.
- The fork does not track the HakaiInstitute repo: sync it only once in a while, as it mostly holds the issues.

## Development workflow

- All work is committed to the `dev` branch in the main checkout (`~/Code/HakaiInstitute/kelpbiodata`), not a worktree unless asked: the user reviews diffs and accepts snapshots there. No feature branches or stacked PRs: a single PR from `dev` to `main` collects the work. Other sessions may share the checkout, so stage only the files this session changed and list any others instead of committing them.
- Commit and push only when asked, to `origin`; a request to push includes the build and `jarl check .` below. Never amend a pushed commit. After a push, show the `dev` PR and its CI, and update its title and description if its contents changed.
- Before pushing, run `Rscript scripts/build.R` and `jarl check .`. CI runs R CMD check and jarl on every push to a PR, and lint is what fails most often: CI installs the latest jarl, so keep the local one current (`jarl --version`), and never assign inside a call (`out <- expect_no_warning(f())`, not `expect_no_warning(out <- f())`).
- Planned work goes in an issue on `poissonconsulting/kelpbiodata`, not session memory, so the next session can find it.
- Before opening or pushing a PR, scan the open issues (`gh issue list --repo poissonconsulting/kelpbiodata`, and the other two repos' forks for cross-repo work) for any the PR resolves, and list each in the PR description as `Closes poissonconsulting/kelpbiodata#<n>`. GitHub closes them only when the PR merges into `main`; close any left open by hand after merging.

## Common Commands

| Task | Command |
|------|---------|
| Routine build | `Rscript scripts/build.R` (`document()` -> `install()`) |
| Full check (slow) | `Rscript scripts/build.R --check` (adds `R CMD check`) |
| pkgdown site | `Rscript scripts/build.R --site` |

The build runs are also Positron/VS Code tasks ("kelpbiodata: ..."). The package has no tests: `build.R` documents and installs only.

## Layout

| Path | Contents |
|------|----------|
| `data-raw/data_hakai.R` | Reshapes the hakai-kelp-biomass-25 analysis project's modelling data to kelpbio's columns and writes `data-raw/real/*.csv`, the frozen inputs to the fits |
| `data-raw/fit_<model>_<source>_<species>.R` | One script per reference fit: fits the CSV with the installed kelpbio and writes `data/` with `usethis::use_data()` |
| `data/` | The reference fits (`LazyData`, xz-compressed); each fit's data are in `fit$data` |
| `R/fits.R` | Documentation of the reference fits |

## Key Rules

- **Pre-release** (version `0.0.0.9000`): no NEWS entries, version bumps, deprecations or backward compatibility; rename freely. From the first release, follow the tidyverse release process: a NEWS bullet for each user-facing change, semantic versions set with `usethis::use_version()`, and lifecycle for deprecations.
- Every object in `data/` is built by a script in `data-raw/`; never hand-edit or save objects from an interactive session.
- The real data come from the analysis project `~/Analyses/poissonconsulting/hakai-kelp-biomass-25/` (read-only), via `data-raw/data_hakai.R`; check it for site names, protocols and what each dataset holds.
- A reference fit is a kelpbio fit object; kelpbio is not a dependency, as the fits load without it; the fit scripts call it as `kelpbio::`, from the installed kelpbio. Install kelpbio from the branch the fits should reflect (the tip of kelpbio's stack) before refitting, and say which commit it was.
- Rebuild a reference fit (run its `data-raw/fit_*.R` script) when kelpbio changes that model, its Stan code or the shared fit object, or when its frozen CSV in `data-raw/real/` changes. Any other change needs only `build.R`.
- Fitting is Stan MCMC and slow: confirm before running a fit script, unless it is part of a change the user approved.
