#' Convert numbers to ordinal character vectors (first, second, third)
#'
#' Adds ordinal suffixes to numbers (or a character vector of number-like
#' words).
#' Converts numeric vectors to cardinal numbers before adding prefixes unless
#' `cardinal` is `FALSE`.
#'
#' @param x A numeric or character vector.
#' @param cardinal Whether to convert a numeric vector with [cardinal()]
#'     before applying ordinal suffixes.
#'     When `TRUE`, 1 -> "first".
#'     When `FALSE`, 1 -> "1st".
#'     Defaults to `TRUE`.
#' @param ... Further arguments passed to [cardinal()] when `cardinal`
#'     is `TRUE`.
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/ordinal.R

ordinal <- function(x, cardinal = TRUE, ...) {
  if (!length(x))                 return(character(0))
  if (all(is.na(x) & !is.nan(x))) return(as.character(x))
  if (!is.numeric(x) & !is.character(x))
    stop("`x` must be a numeric or character vector")

  numeric <- x

  if (is.numeric(x)) {
    if (cardinal) {
      x <- cardinal(x, ...)
    } else {
      x <- format(x, scientific = FALSE)
    }
  }

  x <- trimws(x)

  suffix <- rep("th", length(x))
  suffix[str_detect(x, "((?<!1)1|one)$")] <- "st"
  suffix[str_detect(x, "((?<!1)2|two)$")] <- "nd"
  suffix[str_detect(x, "((?<!1)3|three)$")] <- "rd"

  # Convert numeric roots to combining forms
  x <- str_replace_all(x, c(
    "one$" = "fir",
    "two$" = "seco",
    "three$" = "thi",
    "ve$" = "f", # "five" -> "fifth", "twelve" -> "twelfth"
    "[et]$" = "", # "eight" -> "eighth", "nine" -> "ninth"
    "y$" = "ie" # "twenty" -> "twentieth"
  ))

  ordinal <- paste0(x, suffix)
  ordinal <- str_replace_all(ordinal, " ", "-")

  ordinal[!is.na(x) & x == "NaN"] <- NaN
  ordinal[is.na(x)]               <- NA

  args        <- as.list(match.call()[-1])
  args[["x"]] <- NULL

  structure(
    ordinal,
    numeric = numeric,
    nombre  = "ordinal",
    args    = args,
    class   = c("nombre", "character")
  )
}

#' @rdname ordinal
#' @export

nom_ord <- ordinal
