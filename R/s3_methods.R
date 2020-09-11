#' @export
as.character.nombre <- function(x, ...) {
  attributes(x) <- NULL
  class(x)      <- "character"
  x
}

#' @export
as.double.nombre <- function(x, ...) {
  x <- attr(x, "numeric")
  NextMethod()
}

#' @export
as.integer.nombre <- function(x, ...) {
  x <- attr(x, "numeric")
  NextMethod()
}

#' @export
as.logical.nombre <- function(x, ...) {
  x <- attr(x, "numeric")
  NextMethod()
}

#' @export
print.nombre <- function(x, ...) {
  x <- as.character(x)
  NextMethod()
}

#' @export
Math.nombre <- function(x, ...) {
  fun  <- attr(x, "nombre")
  args <- attr(x, "args")
  x    <- as.numeric(x)

  do.call(fun, c(list(NextMethod()), args))
}

#' @export
Summary.nombre <- function(x, ...) {
  if (.Generic %in% c("all", "any")) {
    x <- as.logical(x)
    return(NextMethod())
  }

  fun  <- attr(x, "nombre")
  args <- attr(x, "args")
  x    <- as.numeric(x)

  do.call(fun, c(list(NextMethod()), args))
}

#' @export
Ops.nombre <- function(e1, e2 = NULL) {
  if (
    is.character(e1) && is.character(e2) && (
      .Generic %in% c("==", "!=") ||
      !inherits(e2, "nombre") ||
      !inherits(e1, "nombre")
    )
  ) {
    return(NextMethod())
  }

  if (inherits(e2, "nombre")) {
    fun  <- attr(e2, "nombre")
    args <- attr(e2, "args")
    e2   <- as.numeric(e2)
  }

  if (inherits(e1, "nombre")) {
    fun  <- attr(e1, "nombre")
    args <- attr(e1, "args")
    e1   <- as.numeric(e1)
  }

  result <- NextMethod()

  if (is.numeric(result)) {
    result <- do.call(fun, c(list(result), args))
  }

  result
}
