#' Set a configuration parameter
#'
#' Set a configuration parameter, for the package we are calling from.
#' If called from the R prompt and not from a package, then it sets the
#' parameter for global environment.
#'
#' @param ... Parameters to set, they should be all named.
#'
#' @return Unlike [pkgconfig::set_config()], invisibly returns the previous
#'   values of all the parameters changed, similar to [options()].
#'   This allows previous values to be stored in a variable and restored later.
#'
#' @seealso [pkgconfig::get_config()] and [pkgconfig::set_config()]
#' @export
#'
#' @example examples/set_config.R

set_config <- function(...) {
  input <- list(...)
  if (is.null(names(input))) {input <- unlist(input, recursive = FALSE)}

  if (is.null(names(input)) || any(names(input) == "")) {
    stop("Some parameters are not named")
  }

  values        <- lapply(names(input), pkgconfig::get_config)
  names(values) <- names(input)

  do.call(pkgconfig::set_config_in, c(input, .in = parent.frame()))

  return(invisible(values))
}

#' @importFrom pkgconfig get_config
#' @export
pkgconfig::get_config
