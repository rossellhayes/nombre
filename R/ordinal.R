#' Convert numbers to ordinal character vectors
#'
#' Adds ordinal suffixes to numbers (or a character vector of number-like
#' words).
#' Converts numeric vectors to cardinal numbers before adding prefixes unless
#' `cardinal` is `FALSE`.
#'
#' @param x A numeric or character vector
#' @param cardinal Whether to convert a numeric vector to cardinal numbers
#'     before applying ordinal suffixes.
#'     When `TRUE`, 1 -> "first".
#'     When `FALSE`, 1 -> "1st".
#'     Defaults to `TRUE`.
#' @param negative A character of length one to append to negative numbers.
#'     Defaults to `"negative"`.
#'     Default can be changed by setting `options("nombre.negative")`.
#'
#' @return A character vector of the same length as `x`
#' @export
#'
#' @example examples/ordinal.R

ordinal <- function(
  x, cardinal = TRUE, negative = getOption("nombre.negative", "negative")
) {
  if (!length(x)) return(character(0))
  if (!is.numeric(x) & !is.character(x))
    stop("`x` must be a numeric or character vector")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1)   stop("`negative` must be length one")

  ordinal <- rep("", length(x))

  if (is.numeric(x)) {
    if (cardinal) {
      x <- cardinal(x, negative = negative)
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

  ordinal <- gsub(" ", "-", ordinal)

  ordinal
}

#' @rdname ordinal
#' @export

nom_ord <- ordinal
