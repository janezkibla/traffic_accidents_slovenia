col.width <- c(9, 1, 4, 10, 5, 1, 1, 5, 25, 5, 25, 4, 1, 2, 2, 1, 1, 2, 2)
colnames.95 <- c("stevila_zadeve", "klas", "upr_enota", "datum", "ura",
  "ind_naselje", "katagorija_ceste", "oznaka_naselja",
  "tekst_naselja", "oznaka_odseka", "tekst_odseka",
  "hisna_stevilka", "opis_prizorisca", "vzrok_nesrece",
  "tip_nesrece", "vreme", "stanje_prometa", "stanje_povrsine",
  "stanje_vozisca")

colnames.22 <- c("stevilo_nesrec", "klasifikacija_nesrece",
                 "upravna_enota_nesrece", "datum_nesrece",
                 "ura_nesrece", "nesreca_v_neselju",
                 "katagorije_ceste_nesrece", "oznak_odseka_nesrece",
                 "tekst_ceste_ali_naselja_nesrece",
                 "oznaka_ceste_ali_ulive_nesrece",
                 "tekst_odseka_ali_ulice_nesrece",
                 "tocka_hisna_stevilka_nesrece", "opis_prizorisca_nesrece",
                 "vzrok_nesrece", "tip_nesrece", "vreme_okolje_nesrece",
                 "stanje_prometa_nesrece",
                 "stanje_prometa_nesrece")

year <- list.files(pattern = "^(?i)pn\\d{2}\\.txt", recursive = TRUE)
out <- list()

message("processing data 1995-2004")
for (i in seq_along(year)) {
  out[[i]] <- read.fwf(
    file = year[i],
    header = FALSE, 
    widths = col.width,
    fileEncoding = "CP852")
}

result <- do.call(rbind, out)
colnames(result) <- colnames.95

year05 <- list.files(pattern = "^pn\\d{4}\\.csv$", recursive = TRUE)
out <- list()

message("processing data 2005+")
for (i in seq_along(year)) {
  out[[i]] <- read.table(
    file = year05[1],
    header = TRUE,
    sep = ";",
    fileEncoding = "ISO-8859-1")
}

result05 <- do.call(rbind, out)
# colnames(result05) <- colnames.22

save(result, result05, file = "./data/raw_data_1995_2021.RData")
