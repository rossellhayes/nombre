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
#'     Default can be changed with
#'     [set_config("nombre::ord_cardinal")][set_config()].
#' @param ... Further arguments passed to [cardinal()] when `cardinal`
#'     is `TRUE`.
#'
#' @return A character vector of the same length as `x`
#' @family number names
#' @export
#' @example examples/ordinal.R

ordinal <- function(
  x, cardinal = get_config("nombre::ord_cardinal", TRUE), ...
) {
  if (!length(x)) return(character(0))
  if (!is.numeric(x) & !is.character(x))
    stop("`x` must be a numeric or character vector")

  numeric <- x
  ordinal <- character(length(x))

  if (is.numeric(x)) {
    if (cardinal) {
      x <- cardinal(x, ...)
    } else {
      x <- format(x, scientific = FALSE)
    }
  }

  one_num <- ordinal == "" & grepl("(?<!1)1$", x, perl = TRUE)
  ordinal[one_num] <- paste0(x[one_num], "st")

  two_num <- ordinal == "" & grepl("(?<!1)2$", x, perl = TRUE)
  ordinal[two_num] <- paste0(x[two_num], "nd")

  three_num <- ordinal == "" & grepl("(?<!1)3$", x, perl = TRUE)
  ordinal[three_num] <- paste0(x[three_num], "rd")

  one <- ordinal == "" & grepl("one$", x)
  ordinal[one] <- gsub("one$", "first", x[one])

  two <- ordinal == "" & grepl("two$", x)
  ordinal[two] <- gsub("two$", "second", x[two])

  three <- ordinal == "" & grepl("three$", x)
  ordinal[three] <- gsub("three$", "third", x[three])

  nine <- ordinal == "" & grepl("nine$", x)
  ordinal[nine] <- gsub("nine$", "ninth", x[nine])

  ve <- ordinal == "" & grepl("ve$", x)
  ordinal[ve] <- gsub("ve$", "fth", x[ve])

  y <- ordinal == "" & grepl("y$", x)
  ordinal[y] <- gsub("y$", "ieth", x[y])

  t <- ordinal == "" & grepl("t$", x)
  ordinal[t] <- paste0(x[t], "h")

  ordinal[ordinal == ""] <- paste0(x[ordinal == ""], "th")

  ordinal <- gsub(" ", "-", trimws(ordinal))

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
