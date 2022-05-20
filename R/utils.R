str_detect <- function(string, pattern) {
  grepl(pattern = pattern, x = string, perl = TRUE)
}

str_replace_all <- function(string, pattern, replacement) {
  if (!is.null(names(pattern))) {
    for (i in seq_along(pattern)) {
      string <- gsub(
        pattern = names(pattern)[[i]],
        replacement = pattern[[i]],
        x = string,
        perl = TRUE
      )
    }

    return(string)
  }

  gsub(pattern = pattern, replacement = replacement, x = string, perl = TRUE)
}

str_remove_all <- function(string, pattern) {
  gsub(pattern = pattern, replacement = "", x = string, perl = TRUE)
}
