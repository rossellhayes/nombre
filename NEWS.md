# nombre (development version)

## New features

* `cardinal()` gains the argument `max_n`, which stops numbers greater that
  `max_n` from being cardinalized.
  This is useful when you want to print small numbers in words but larger
  numbers numerically.
  Refactorization means this argument can be used by all functions.
  
* All functions now pass `...` to lower level functions.
  Passing follows the sequence `denominator()` -> `ordinal()` -> `cardinal()`.
  This allows `cardinal()`'s `max_n` and `negative` to be used by all functions
  and `ordinal()`'s `cardinal` to be used by `denominator()`.
  
## Bug fixes

* `ordinal()` now handles uncardinalized numeric vectors with different numbers
  of digits correctly.
  Previously, dashes would be appended to the start of the shorter numbers.
  `nom_ord(c(9, 10), cardinal = FALSE)` now produces "9th, 10th" as expected,
  instead of "-9th, 10th" as it did previously.

# nombre 0.1.0

* Initial release
