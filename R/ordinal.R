#' Convert numbers to ordinal character vectors
#'
#' @param x A numeric vector
#' @param negative A character of length one to append to negative numbers.
#'     Defaults to `"negative"`.
#'     Default can be changed by setting `options("numerate.negative")`.
#'
#' @return A character vector of the same length as `x`
#' @export
#'
#' @example examples/ordinal.R

ordinal <- function(x, negative = getOption("numerate.negative", "negative")) {
  if (!length(x))              return(character(0))
  if (!is.numeric(x))          stop("`x` must be numeric")
  if (!is.character(negative)) stop("`negative` must be of type character")
  if (length(negative) != 1)   stop("`negative` must be length one")

  cardinal <- cardinal(x, negative = negative)
  ordinal  <- rep("", length(x))

  one <- ordinal == "" & grepl("one$", cardinal)
  ordinal[one] <- gsub("one$", "first", cardinal[one])

  two <- ordinal == "" & grepl("two$", cardinal)
  ordinal[two] <- gsub("two$", "second", cardinal[two])

  three <- ordinal == "" & grepl("three$", cardinal)
  ordinal[three] <- gsub("three$", "third", cardinal[three])

  eight <- ordinal == "" & grepl("eight$", cardinal)
  ordinal[eight] <- gsub("eight$", "eighth", cardinal[eight])

  nine <- ordinal == "" & grepl("nine$", cardinal)
  ordinal[nine] <- gsub("nine$", "ninth", cardinal[nine])

  ve <- ordinal == "" & grepl("ve$", cardinal)
  ordinal[ve] <- gsub("ve$", "fth", cardinal[ve])

  y <- ordinal == "" & grepl("y$", cardinal)
  ordinal[y] <- gsub("y$", "ieth", cardinal[y])

  ordinal[ordinal == ""] <- paste0(cardinal[ordinal == ""], "th")

  ordinal <- gsub(" ", "-", ordinal)

  ordinal
}

#' @rdname ordinal
#' @export

nmr_ord <- ordinal
