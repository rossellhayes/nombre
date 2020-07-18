# nombre (development version)

* Terminating decimals with denominators greater than 10 now always produce a
  power-of-ten denominator.
  - `cardinal(1/20)` now produces "five hundredths", but:
    - `cardinal(1/8)` still produces "one eighth" (denominator is less than 10) 
    - `cardinal(1/30)` still produces "one thirtieth" (non-terminating decimal)

* Refactor `decimal_to_fraction()` into an Rcpp function.
  This allows `cardinal()` to generate fractional components in roughly one
  tenth the time of the R implementation of `decimal_to_fraction()`.

# nombre 0.2.0

## New features

* `cardinal()` gains the argument `max_n`, which stops numbers greater that
  `max_n` from being cardinalized.
  This is useful when you want to print small numbers in words but larger
  numbers numerically.
  Refactorization means this argument can be used by all functions.
  - `options("nombre.max_n")` sets a default value.
  
* `adverbial()` and `nom_adv()` generate adverbials, e.g. "once", "twice",
  "three times".
  - `thrice = TRUE` or `options("nombre.thrice" = TRUE)` convert `3` to "thrice"
    instead of "three times".
  
* All functions now pass `...` to lower level functions.
  `ordinal()` and `adverbial()` pass to `cardinal()`.
  `denominator()` passes to `ordinal()`.
  This allows `cardinal()`'s `max_n` and `negative` to be used by all functions
  and `ordinal()`'s `cardinal` to be used by `denominator()`.
  
## Bug fixes

* `ordinal()` now handles uncardinalized numeric vectors with different numbers
  of digits correctly.
  Previously, dashes would be appended to the start of the shorter numbers.
  `nom_ord(c(9, 10), cardinal = FALSE)` now produces "9th, 10th" as expected,
  instead of "-9th, 10th" as it did previously.
  
## Miscellaneous

* Implemented a custom function to convert decimals to fractions.
  This removes the previous previous dependency on {MASS}.
  
* Added package documentation page at `?nombre`

# nombre 0.1.0

* Initial release
