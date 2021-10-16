
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nombre <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/nombre?color=brightgreen)](https://cran.r-project.org/package=nombre)
[![](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://cran.r-project.org/web/licenses/MIT)
[![R build
status](https://github.com/rossellhayes/nombre/workflows/R-CMD-check/badge.svg)](https://github.com/rossellhayes/nombre/actions)
[![](https://codecov.io/gh/rossellhayes/nombre/branch/master/graph/badge.svg)](https://codecov.io/gh/rossellhayes/nombre)
[![Dependencies](https://tinyverse.netlify.com/badge/nombre)](https://cran.r-project.org/package=nombre)
<!-- badges: end -->

> *nombre* (French) /nɔ̃bʁ/: number  
> *nombre* (Spanish) /ˈnom.bɾe/: name  
> `nombre`: package to convert numbers to their names in R

**nombre** converts numeric vectors to character vectors of English
words. You can use it to express numbers as cardinals (one, two, three)
or ordinals (first, second, third), as well as numerators and
denominators. **nombre** supports not just whole numbers, but also
negatives, fractions, and ratios.

## Installation

You can install the released version of **nombre** from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nombre")
```

or the development version from GitHub with:

``` r
# install.packages("remotes")
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

**nombre** can also generate ordinals, adverbials, collectives,
numerators and denominators:

``` r
nom_ord(1:5)
#> [1] "first"  "second" "third"  "fourth" "fifth"
nom_adv(1:5)
#> [1] "once"        "twice"       "three times" "four times"  "five times"
nom_coll(1:5)
#> [1] "the"       "both"      "all three" "all four"  "all five"
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

It can also handle less common numerics, like negatives, fractions, and
ratios:

``` r
nom_card(-2)
#> [1] "negative two"
nom_card(9.75)
#> [1] "nine and three quarters"
nom_ratio(0.25)
#> [1] "one to four"
nom_ratio(3)
#> [1] "three to one"
```

### Math with nombres

**nombre** implements an S3 class that seamlessly decides when to treat
nombres like characters and when to treat them like numerics.

``` r
x <- nom_card(25)
x
#> [1] "twenty-five"
x + 2
#> [1] "twenty-seven"
sqrt(x)
#> [1] "five"
x < 30
#> [1] TRUE
x == "twenty-five"
#> [1] TRUE
```

### Reverse it

`uncardinal()` attempts to convert character vectors of cardinal number
names to numerics.

``` r
uncardinal(c("twenty-five", "negative three", "infinity"))
#> [1]  25  -3 Inf
```

## Advantages 🚀

**nombre** is implemented using vectorized base R and runs faster than
alternatives like
[**english**](https://CRAN.R-project.org/package=english):

``` r
bench::mark(as.character(nom_card(1:1000)), as.character(english::english(1:1000)))
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> # A tibble: 2 × 6
#>   expression                                  min   median `itr/sec` mem_alloc
#>   <bch:expr>                             <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 as.character(nom_card(1:1000))           4.28ms   4.45ms     207.     1.02MB
#> 2 as.character(english::english(1:1000))  79.25ms  81.58ms      12.2  389.44KB
#> # … with 1 more variable: gc/sec <dbl>
```

------------------------------------------------------------------------

Hex sticker image adapted from artwork by
@[allison\_horst](https://github.com/allisonhorst/stats-illustrations).

Hex sticker fonts are [Source Sans
Pro](https://github.com/adobe-fonts/source-sans-pro) by
[Adobe](https://www.adobe.com) and [Permanent
Marker](https://www.fontsquirrel.com/fonts/permanent-marker) by [Font
Diner](https://www.fontdiner.com/).

Please note that **nombre** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
