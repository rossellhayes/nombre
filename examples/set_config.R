nom_adv(3)
default_adv <- set_config("nombre::thrice" = TRUE)
nom_adv(3)

nom_card(c(-1, 1e4))
default_card <- set_config("nombre::max_n" = 100, "nombre::negative" = "minus")
nom_card(c(-1, 1e4))

nom_denom(4)
default_denom <- set_config("nombre::quarter" = FALSE)
nom_denom(4)

set_config(default_adv, default_card, default_denom)
nom_adv(3)
nom_card(c(-1, 1e4))
nom_denom(4)
