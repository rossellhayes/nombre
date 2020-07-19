#include <Rcpp.h>
#include <limits>
using namespace Rcpp;
// [[Rcpp::export]]
IntegerVector decimal_to_fraction(double x) {
  if ((x <= 0) | (x >= 1)) {stop("`x` must be between 0 and 1");}

  int numerator             = 0;
  int numerator_guess       = 0;
  int denominator           = 1;
  int denominator_guess     = 1;
  double fraction           = 0;
  double fraction_guess     = 0;
  double epsilon            = std::numeric_limits<double>::epsilon();
  double sqrt_eps           = std::sqrt(epsilon);
  IntegerVector terminators = IntegerVector::create(
    2, 4, 5, 8, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7
  );

  if (x - 0 < sqrt_eps) {
    numerator   = 0;
    denominator = 1e7;
    fraction    = x;
  } else if (1 - x < sqrt_eps) {
    numerator   = 1e7;
    denominator = 1e7;
    fraction    = x;
  } else for (
    IntegerVector::iterator i = terminators.begin(); i != terminators.end(); ++i
  ) {
    denominator_guess = *i;
    numerator_guess   = (int) R::fround(x * denominator_guess, 0);
    fraction_guess    = (double) numerator_guess / denominator_guess;

    if (std::abs(x - fraction_guess) < std::abs(x - fraction)) {
      numerator   = numerator_guess;
      denominator = denominator_guess;
      fraction    = (double) numerator / denominator;
    }
  }

  if (std::abs(x - fraction) > sqrt_eps) {
    int numerator_min   = 0;
    int numerator_max   = 1;
    int denominator_min = 1;
    int denominator_max = 1;
    denominator_guess   = 1;

    while (std::abs(x - fraction) > epsilon) {
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

      if (std::abs(x - fraction_guess) < std::abs(x - fraction)) {
        numerator   = numerator_guess;
        denominator = denominator_guess;
        fraction    = (double) numerator / denominator;
      }
    }
  }

  IntegerVector result = IntegerVector::create(numerator, denominator);
  result.attr("dim")   = Dimension(2, 1);
  return result;
}

// decimal_to_fraction = function(x) {
//   if ((x <= 0) | (x >= 1)) {stop("`x` must be between 0 and 1");}
//
//   numerator         = 0;
//   numerator_guess   = 0;
//   numerator_min     = 0;
//   numerator_max     = 1;
//   denominator       = 1;
//   denominator_guess = 1;
//   denominator_min   = 1;
//   denominator_max   = 1;
//   i                 = 5;
//   fraction          = 0;
//   fraction_guess    = 0;
//   epsilon           = sqrt(.Machine$double.eps);
//
//
//   if (x - 0 < epsilon) {
//     numerator   = 0;
//     denominator = 1e7;
//     fraction    = x;
//   } else if (1 - x < epsilon) {
//     numerator   = 1e7;
//     denominator = 1e7;
//     fraction    = x;
//   } else while ((i < 1 / epsilon) & (abs(x - fraction) > epsilon)) {
//     denominator_guess = i;
//     numerator_guess   = round(x * denominator_guess);
//     fraction_guess    = numerator_guess / denominator_guess;
//
//     if (abs(x - fraction_guess) < abs(x - fraction)) {
//       numerator   = numerator_guess;
//       denominator = denominator_guess;
//       fraction    = numerator / denominator;
//     }
//
//     i = (i == 5) * 2 + (i < 5) * (i * 2) + (i == 8) * 10 + (i >= 10) * (i * 10);
//   }
//
//   if (abs(x - fraction) > epsilon) {
//     denominator_guess = 1;
//
//     while (abs(x - fraction) > .Machine$double.eps) {
//       numerator_guess   = numerator_min   + numerator_max;
//       denominator_guess = denominator_min + denominator_max;
//       fraction_guess    = numerator_guess / denominator_guess;
//
//       if (fraction_guess > x) {
//         numerator_max   = numerator_guess;
//         denominator_max = denominator_guess;
//       } else {
//         numerator_min   = numerator_guess;
//         denominator_min = denominator_guess;
//       }
//
//       if (abs(x - fraction_guess) < abs(x - fraction)) {
//         numerator   = numerator_guess;
//         denominator = denominator_guess;
//         fraction    = numerator / denominator;
//       }
//     }
//   }
//
//   matrix(c(numerator, denominator));
// }
