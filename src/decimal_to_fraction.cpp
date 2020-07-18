#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
IntegerVector decimal_to_fraction(double x) {
  if ((x <= 0) | (x >= 1)) {stop("`x` must be between 0 and 1");}

  int numerator         = 0;
  int numerator_guess   = 0;
  int numerator_min     = 0;
  int numerator_max     = 1;
  int denominator       = 1;
  int denominator_guess = 1;
  int denominator_min   = 1;
  int denominator_max   = 1;
  int i                 = 5;
  double fraction       = 0;
  double fraction_guess = 0;

  if (x - 0 < sqrt(DBL_EPSILON)) {
    numerator   = 0;
    denominator = 1e7;
    fraction    = x;
  } else if (1 - x < sqrt(DBL_EPSILON)) {
    numerator   = 1e7;
    denominator = 1e7;
    fraction    = x;
  } else while ((i < 1e7) & (abs(x - fraction) > sqrt(DBL_EPSILON))) {
    denominator_guess = i;
    numerator_guess   = (int) round(x * denominator_guess);
    fraction_guess    = (double) numerator_guess / denominator_guess;

    if (abs(x - fraction_guess) < abs(x - fraction)) {
      numerator   = numerator_guess;
      denominator = denominator_guess;
      fraction    = (double) numerator / denominator;
    }

    i = (i == 5) * 2 + (i < 5) * (i * 2) + (i == 8) * 10 + (i >= 10) * (i * 10);
  }

  denominator_guess = 1;

  while (abs(x - fraction) > sqrt(DBL_EPSILON)) {
    numerator_guess   = numerator_min   + numerator_max;
    denominator_guess = denominator_min + denominator_max;
    fraction_guess    = (double) numerator_guess / denominator_guess;

    if (fraction_guess > x) {
      numerator_max   = numerator_guess;
      denominator_max = denominator_guess;
    } else {
      numerator_min   = numerator_guess;
      denominator_min = denominator_guess;
    }

    if (abs(x - fraction_guess) < abs(x - fraction)) {
      numerator   = numerator_guess;
      denominator = denominator_guess;
      fraction    = (double) numerator / denominator;
    }
  }

  IntegerVector result = IntegerVector::create(numerator, denominator);
  result.attr("dim")   = Dimension(2, 1);
  return result;
}
