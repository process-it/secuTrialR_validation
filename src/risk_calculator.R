# 1 = low, 2 = medium, 3 = high
risk_calculator <- function(severity, probability, detectability) {

  if (! is.numeric(c(severity, probability, detectability))) {
    stop("Only numeric inputs 1, 2 and 3 allowed.")
  }

  if (any(c(severity, probability, detectability) < 0 |
          c(severity, probability, detectability) > 3)) {
    stop("Only numbers 1, 2 and 3 allowed.")
  }

  # combine two risk categories into one
  combine_catergories <- function(cat_1, cat_2) {
    product <- cat_1 * cat_2
    if (product > 5) {
      combined <- 3
    } else if (product > 2) {
      combined <- 2
    } else if (product <= 2) {
      combined <- 1
    }
    return(combined)
  }

  # first combine severity and probability to risk class
  risk_class <- combine_catergories(severity, probability)
  # combine risk class and detectability to final risk
  risk <- combine_catergories(risk_class, detectability)
  return(risk)
}
