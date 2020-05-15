
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nombre <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)
[![R build
status](https://github.com/rossellhayes/nombre/workflows/R-CMD-check/badge.svg)](https://github.com/rossellhayes/nombre/actions)
[![Codecov test
coverage](https://codecov.io/gh/rossellhayes/nombre/branch/master/graph/badge.svg)](https://codecov.io/gh/rossellhayes/nombre?branch=master)
<!-- badges: end -->

> *nombre* (French) /nɔ̃bʁ/: number  
> *nombre* (Spanish) /ˈnom.bɾe/: name  
> `nombre`: package to convert numbers to their names in R

**nombre** converts numeric vectors to character vectors of English
words. You can use it to express numbers as cardinals (one, two, three)
or ordinals (first, second, third), as well as numerators and
denominators. **nombre** supports not just whole numbers, but also
negatives and fractions.

## Installation

You can install the development version of **nombre** from GitHub with:

``` r
remotes::install_github("rossellhayes/nombre")
```

## Usage

**nombre** converts numerics into words:

``` r
nom_card(2)
#> [1] "two"
nom_card(2L)
#> [1] "two"
x <- rep(TRUE, 525600)
nom_card(length(x))
#> [1] "five hundred twenty-five thousand six hundred"
```

It also works for numeric vectors:

``` r
nom_card(8^(1:10))
#>  [1] "eight"                                                                                       
#>  [2] "sixty-four"                                                                                  
#>  [3] "five hundred twelve"                                                                         
#>  [4] "four thousand ninety-six"                                                                    
#>  [5] "thirty-two thousand seven hundred sixty-eight"                                               
#>  [6] "two hundred sixty-two thousand one hundred forty-four"                                       
#>  [7] "two million ninety-seven thousand one hundred fifty-two"                                     
#>  [8] "sixteen million seven hundred seventy-seven thousand two hundred sixteen"                    
#>  [9] "one hundred thirty-four million two hundred seventeen thousand seven hundred twenty-eight"   
#> [10] "one billion seventy-three million seven hundred forty-one thousand eight hundred twenty-four"
```

**nombre** can also generate ordinals, numerators and denominators:

``` r
nom_ord(1:5)
#> [1] "first"  "second" "third"  "fourth" "fifth"
nom_numer(1:5)
#> [1] "one"   "two"   "three" "four"  "five"
nom_denom(1:5)
#> [1] "whole"   "half"    "third"   "quarter" "fifth"
nom_denom(1:5, numerator = 1:5)
#> [1] "whole"    "halves"   "thirds"   "quarters" "fifths"
```

> 🤫 (numerators are almost always the same as cardinals)

You can also add ordinal suffixes to numerics or arbitrary number-like
strings:

``` r
nom_ord(1:5, cardinal = FALSE)
#> [1] "1st" "2nd" "3rd" "4th" "5th"
nom_ord(c("n", "dozen", "umpteen", "eleventy", "one zillion"))
#> [1] "nth"           "dozenth"       "umpteenth"     "eleventieth"  
#> [5] "one-zillionth"
```

It can also handle less common numerics, like negative and fractions:

``` r
nom_card(-2)
#> [1] "negative two"
nom_card(99.9)
#> [1] "ninety-nine and nine tenths"
```

## Advantages 🚀

**nombre** is implemented using vectorized base R. This allows it to run
faster than options that implement their own object class, like
[**english**](https://CRAN.R-project.org/package=english):

``` r
bench::mark(nom_card(1:1000), as.character(english::english(1:1000)))
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> # A tibble: 2 x 6
#>   expression                                  min   median `itr/sec` mem_alloc
#>   <bch:expr>                             <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 nom_card(1:1000)                         7.59ms   9.05ms    103.       841KB
#> 2 as.character(english::english(1:1000)) 124.85ms 130.35ms      7.40     389KB
#> # ... with 1 more variable: `gc/sec` <dbl>
```

**nombre** also does not require dependencies for most of its
functionality. The suggested package
[**MASS**](https://CRAN.R-project.org/package=MASS) is only required for
handling non-integers, a situation that should be rare for most packages
considering implementing **nombre**.

-----

Hex sticker image adapted from artwork by
@[allison\_horst](https://github.com/allisonhorst/stats-illustrations).

Hex sticker fonts are [Source Code
Pro](https://github.com/adobe-fonts/source-code-pro) by
[Adobe](https://adobe.com) and [Permanent
Marker](https://www.fontsquirrel.com/fonts/permanent-marker) by [Font
Diner](https://www.fontdiner.com/).

Please note that **nombre** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
