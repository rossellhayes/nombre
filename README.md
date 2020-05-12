
<!-- README.md is generated from README.Rmd. Please edit that file -->

# numerate <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

> *numerate* (adj.): numerically literate

**numerate** converts numeric vectors to character vectors of English
words. You can use it to express numbers as cardinals (one, two, three)
or ordinals (first, second, third), as well as numerators and
denominators. **numerate** supports not just whole numbers, but also
negatives and fractions.

## Installation

You can install the development version of **numerate** from GitHub
with:

``` r
remotes::install_github("rossellhayes/numerate")
```

## Usage

**numerate** converts numerics into words:

``` r
nmr_card(2)
#> [1] "two"
nmr_card(2L)
#> [1] "two"
x <- rep(TRUE, 525600)
nmr_card(length(x))
#> [1] "five hundred twenty-five thousand six hundred"
```

It also works for numeric vectors:

``` r
nmr_card(8^(1:10))
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

**numerate** can also generate ordinals, numerators and denominators:

``` r
nmr_ord(1:5)
#> [1] "first"  "second" "third"  "fourth" "fifth"
nmr_num(1:5)
#> [1] "one"   "two"   "three" "four"  "five"
nmr_denom(1:5)
#> [1] "whole"   "half"    "third"   "quarter" "fifth"
nmr_denom(1:5, numerator = 1:5)
#> [1] "whole"    "halves"   "thirds"   "quarters" "fifths"
```

> 🤫 (numerators are almost always the same as cardinals)

It can also handle less common numerics, like negative and fractions:

``` r
nmr_card(-2)
#> [1] "negative two"
nmr_card(99.9)
#> [1] "ninety-nine and nine tenths"
```

## Advantages 🚀

**numerate** is implemented using vectorized base R. This allows it to
run faster than options that implement their own object class, like
[**english**](https://cran.r-project.org/web/packages/english/):

``` r
bench::mark(nmr_card(1:1000), as.character(english::english(1:1000)))
#> # A tibble: 2 x 6
#>   expression                               min   median `itr/sec` mem_alloc
#>   <bch:expr>                             <bch> <bch:tm>     <dbl> <bch:byt>
#> 1 nmr_card(1:1000)                         7ms   8.56ms    117.       841KB
#> 2 as.character(english::english(1:1000)) 141ms 140.84ms      7.10     389KB
#> # ... with 1 more variable: `gc/sec` <dbl>
```

**numerate** also does not require dependencies for most of its
functionality. The suggested package
[**MASS**](https://cran.r-project.org/web/packages/MASS/) is only
required for handling non-integers, a situation that should be rare for
most packages considering implementing **numerate**.

-----

Please note that **numerate** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
