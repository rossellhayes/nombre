nom_card(2)
nom_card(1:10)
nom_card(2 + 4/9)
nom_card(-2)
nom_card(-2, negative = "minus")

nom_card(5:15, max_n = 10)

paste("There are", nom_card(525600), "minutes in a year.")
paste("There are", nom_card(3.72e13), "cells in the human body.")

nom_card(1 / 2^(1:4))
nom_card(1 / 2^(1:4), common_denom = TRUE)
nom_card(1 / 2^(1:4), base_10 = TRUE)
nom_card(1 / 2^(1:4), base_10 = TRUE, common_denom = TRUE)

nom_card(1 / 2:5)
nom_card(1 / 2:5, base_10 = TRUE)
nom_card(1 / 2:5, base_10 = TRUE, max_denom = 100)

nom_card(1 / 4, sep = "in")
nom_card(6 / 25, sep = "in", max_denom = 10)
