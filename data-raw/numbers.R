library(rvest)

digits <- c(
  "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
  "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
  "seventeen", "eighteen", "nineteen"
)

tens <- c(
  "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy",
  "eighty", "ninety"
)

powers <- read_html(
  "http://lcn2.github.io/mersenne-english-name/tenpower/tenpower.html"
) %>%
  html_nodes(xpath = "/html/body/table[2]/tr/td[2]/center/table/tr/td[4]") %>%
  html_text()

powers    <- powers[seq(1, length(powers), 3)]
powers    <- gsub("one", "", powers)
powers    <- paste0(powers, " ")
powers[1] <- ""

usethis::use_data(digits, tens, powers, internal = TRUE, overwrite = TRUE)
