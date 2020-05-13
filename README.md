
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nombre <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)
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

**nombre** can also generate ordinals, numerators and denominators:

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

**nombre** is implemented using vectorized base R. This allows it to run
faster than options that implement their own object class, like
[**english**](https://cran.r-project.org/web/packages/english/):

``` r
bench::mark(nmr_card(1:1000), as.character(english::english(1:1000)))
#> # A tibble: 2 x 6
#>   expression                                  min  median `itr/sec` mem_alloc
#>   <bch:expr>                             <bch:tm> <bch:t>     <dbl> <bch:byt>
#> 1 nmr_card(1:1000)                         7.83ms  10.2ms     98.9      841KB
#> 2 as.character(english::english(1:1000)) 139.23ms 139.2ms      7.18     389KB
#> # ... with 1 more variable: `gc/sec` <dbl>
```

**nombre** also does not require dependencies for most of its
functionality. The suggested package
[**MASS**](https://cran.r-project.org/web/packages/MASS/) is only
required for handling non-integers, a situation that should be rare for
most packages considering implementing **nombre**.

-----

Hex sticker fonts are [Source Code
Pro](https://github.com/adobe-fonts/source-code-pro) by
[Adobe](https://adobe.com) and [Permanent
Marker](https://www.fontsquirrel.com/fonts/permanent-marker) by [Font
Diner](https://www.fontdiner.com/).

Please note that **nombre** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
