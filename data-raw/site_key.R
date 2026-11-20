# Site names are replaced by IDs from a private key (KELPBIODATA_SITE_KEY, a CSV
# with columns site and site_id), so no names are published: HEI001, ... for
# the Heiltsuk sites (named *_HIRMD) and HAK001, ... for the rest. The key also
# maps each spelling of a site in the source files to its ID. A name new to the
# key is given the next free ID and added to it, with a message: if it is a new
# spelling of a known site, give it that site's ID in the key and rerun.

site_key_path <- Sys.getenv("KELPBIODATA_SITE_KEY")
if (!nzchar(site_key_path)) {
  stop("Set KELPBIODATA_SITE_KEY to the path of the site key CSV.", call. = FALSE)
}

read_site_key <- function() {
  if (!file.exists(site_key_path)) {
    return(tibble::tibble(site = character(), site_id = character()))
  }
  readr::read_csv(site_key_path, col_types = "cc", progress = FALSE)
}

site_id <- function(site) {
  key <- read_site_key()
  new <- setdiff(sort(unique(as.character(site[!is.na(site)]))), key$site)
  if (length(new) > 0) {
    prefix <- dplyr::if_else(grepl("HIRMD", new), "HEI", "HAK")
    used <- function(p) {
      n <- as.integer(sub(p, "", key$site_id[startsWith(key$site_id, p)]))
      max(c(0L, n))
    }
    number <- integer(length(new))
    for (p in unique(prefix)) {
      number[prefix == p] <- used(p) + seq_len(sum(prefix == p))
    }
    key <- dplyr::bind_rows(
      key,
      tibble::tibble(site = new, site_id = sprintf("%s%03d", prefix, number))
    )
    readr::write_csv(key, site_key_path)
    message(length(new), " new site(s) added to the site key.")
  }
  key$site_id[match(as.character(site), key$site)]
}
