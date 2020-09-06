# nombre (development version)

* **nombre** outputs are now part of the S3 class `nombre`.
  - This allows `nombre`s to go through mathematical transformations while preserving their characteristics.
  - `cardinal(25) + cardinal(2)` produces `"twenty-seven"`.
  - `adverbial(3) / 3` produces `"once"`.
  - `as.numeric(ordinal(9))` produces `9`.

* Default arguments are now handled with [**pkgconfig**](https://github.com/r-lib/pkgconfig) rather than `options()`.
  - This allows packages that import **nombre** to set defaults without affecting the user or other packages.

* Denominators that begin with "one" now omit the leading "one".
  - `cardinal(3/100)` now produces "three hundredths" rather than "three one-hundredths".
  - `denominator(1)` still produces "whole".
  
* `collective()` gains the arguments `all_n` and `of_the`.
  - `collective(3, all_n = FALSE)` become `"all"` rather than `"all three"`.
  - `collective(0:3, of_the = TRUE)` becomes `c("none of the", "the", "both of the", "all three of the")` rather than `c("no", "the", "both", "all three")`.
  - The default can be changed with `set_config("nombre::of_the")`.

* Decimals are now converted to fractions with [**fracture**](https://github.com/rossellhayes/fracture).
  This allows `cardinal()` to generate fractional components in roughly one tenth the time of the R implementation of `decimal_to_fraction()`.
  - Arguments are passed to `fracture::frac_mat()` with `...`.
  
* Added a `pkgdown` site.

# nombre 0.2.0

## New features

* `cardinal()` gains the argument `max_n`, which stops numbers greater that `max_n` from being cardinalized.
  This is useful when you want to print small numbers in words but larger numbers numerically.
  Refactorization means this argument can be used by all functions.
  - `options("nombre.max_n")` sets a default value.
  
* `adverbial()` and `nom_adv()` generate adverbials, e.g. "once", "twice", "three times".
  - `thrice = TRUE` or `options("nombre.thrice" = TRUE)` convert `3` to "thrice" instead of "three times".
  
* All functions now pass `...` to lower level functions.
  `ordinal()` and `adverbial()` pass to `cardinal()`.
  `denominator()` passes to `ordinal()`.
  This allows `cardinal()`'s `max_n` and `negative` to be used by all functions and `ordinal()`'s `cardinal` to be used by `denominator()`.
  
## Bug fixes

* `ordinal()` now handles uncardinalized numeric vectors with different numbers of digits correctly.
  Previously, dashes would be appended to the start of the shorter numbers.
  `nom_ord(c(9, 10), cardinal = FALSE)` now produces "9th, 10th" as expected, instead of "-9th, 10th" as it did previously.
  
## Miscellaneous

* Implemented a custom function to convert decimals to fractions.
  This removes the previous previous dependency on {MASS}.
  
* Added package documentation page at `?nombre`

# nombre 0.1.0

* Initial release
