#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]
IntegerVector decimal_to_fraction(double x) {
  if ((0 > x) | (x > 1)) {stop("`x` must be between 0 and 1");}

  int a_guess, b_guess;
  int a_min, b_min;
  int a_max, b_max;
  int a_save, b_save;
  int i;

  a_guess = a_min = a_save = 0;
  a_max = b_guess = b_min = b_max = b_save = i = 1;

  while (abs(x - (double)a_save / b_save) > DBL_EPSILON) {
    if (i++ % 100 == 0) {Rcpp::checkUserInterrupt();}

    if (abs(x - (double)a_guess / b_guess) < abs(x - (double)a_save / b_save)) {
      a_save = a_guess;
      b_save = b_guess;
    }

    a_guess = a_min + a_max;
    b_guess = b_min + b_max;

    if (a_guess > (double)x * b_guess) {
      a_max = a_guess;
      b_max = b_guess;
    } else {
      a_min = a_guess;
      b_min = b_guess;
    }
  }

  IntegerVector result = IntegerVector::create(a_save, b_save);
  result.attr("dim") = Dimension(2, 1);
  return result;
}

