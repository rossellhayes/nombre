#' Convert cardinal character vectors to numbers
#'
#' This function is in experimental development.
#' It currently only supports English cardinal integers or character vectors
#' produced by one of [nombre]'s functions.
#'
#' @param x A character vector of the cardinal names of numbers
#'
#' @return A numeric vector the same length as `n`.
#'   NAs will be produced for numbers with fractions or decimals or non-cardinal
#'   numbers (e.g. ordinals).
#'
#' @seealso [cardinal()] to convert numeric vectors to number names
#' @export
#'
#' @examples
#' uncardinal("one")
#' uncardinal("negative one hundred fifty-seven")
#' uncardinal(
#'   c(
#'     "twenty-five",
#'     "one million two hundred thirty-four thousand five hundred sixty-seven"
#'   )
#' )
#' uncardinal("infinity")
#'
#' card <- cardinal(25)
#' uncardinal(card)
#' ord <- ordinal(25)
#' uncardinal(ord)

uncardinal <- function(x) {
  if (inherits(x, "nombre")) {
    return(attr(x, "numeric"))
  }

  powers <- gsub(" ", "", powers)[-1]

  mat   <- strsplit(x, " |\\-")
  max_n <- max(lengths(mat))
  mat   <- vapply(mat, `length<-`, character(max_n), max_n)
  mat[mat %in% powers] <- paste0(
    ") * 10^", match(mat[mat %in% powers], powers) * 3, " + ("
  )
  mat[mat == "hundred"]  <- "* 100 + "
  mat[mat %in% tens]     <- paste0(match(mat[mat %in% tens], tens) * 10, " + ")
  mat[mat %in% digits]   <- paste0(match(mat[mat %in% digits], digits), " + ")
  mat[mat == "zero"]     <- "0"
  mat[mat == "infinity"] <- "Inf"
  mat[mat %in% c("negative", "minus")] <- "-1 * (("
  mat[is.na(mat)]                      <- ""
  mat                                  <- matrix(mat, ncol = length(x))

  eq_str <- apply(mat, 2, paste, collapse = "")
  eq_str <- gsub(" \\+ $",     "",      eq_str)
  eq_str <- gsub(" \\+ \\(?$", " + (0", eq_str)
  eq_str <- gsub(" \\+ \\)",   ")",     eq_str)
  eq_str <- gsub("\\+ \\*",    "*",     eq_str)
  eq_str <- gsub("^([^\\-])", "((\\1",  eq_str)
  eq_str <- paste0(eq_str, "))")

  eval_eq <- function(eq_str) {
    tryCatch(
      as.numeric(eval(parse(text = eq_str))),
      error = function(e) {NA_real_}
    )
  }

  result <- unname(vapply(eq_str, eval_eq, numeric(1)))

  if (any(is.na(result))) {
    na     <- which(is.na(result))
    diff   <- length(na) - 5
    prob_x <- c(
      encodeString(x[na], quote = '"')[1:min(length(na), 5)],
      paste0("and ", cardinal(diff), " more string", "s"[diff > 1])[diff > 0]
    )

    message <- paste("*", paste(prob_x, collapse = ", "), "resulted in NA.")

    warning(
      "Some inputs could not be interpreted as integer cardinals.\n",
      message,
      call. = FALSE
    )
  }

  result
}

#' @rdname uncardinal
#' @export

nom_uncard <- uncardinal
