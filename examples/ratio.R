paste0("Our team is outnumbered ", nom_ratio(10), ".")
paste0("The chances of winning are ", nom_ratio(1/1000000, sep = "in"), ".")

nom_ratio(c(1, 10, 100))
nom_ratio(c(0, 0.5, 1.5))
nom_ratio(c(0, 0.125, 0.625, 1), sep = "out of", common_denom = TRUE)
nom_ratio(5 / 10, sep = "in", base_10 = TRUE)
nom_ratio(6 / 25, sep = "in")
nom_ratio(6 / 25, sep = "out of", max_denom = 10)
