col.width <- c(9, 1, 4, 10, 5, 1, 1, 5, 25, 5, 25, 4, 1, 2, 2, 1, 1, 2, 2)
colnames.95 <- c("stevila_zadeve", "klas", "upr_enota", "datum", "ura",
  "ind_naselje", "katagorija_ceste", "oznaka_naselja",
  "tekst_naselja", "oznaka_odseka", "tekst_odseka",
  "hisna_stevilka", "opis_prizorisca", "vzrok_nesrece",
  "tip_nesrece", "vreme", "stanje_prometa", "stanje_povrsine",
  "stanje_vozisca")

files2000 <- list.files(path = "data", pattern = "^(?i)pn\\d{2}\\.txt", full.names = TRUE)
out2000 <- list()

for (i in seq_along(files2000)) {
  message(sprintf("Processing %s", files2000[i]))
  out2000[[i]] <- read.fwf(
    file = files2000[i],
    header = FALSE, 
    widths = col.width,
    fileEncoding = "CP852")
}
pn2000 <- do.call(rbind, out2000)
colnames(pn2000) <- colnames.95

files2004 <- list.files(path = "data/prenosi/PN", pattern = "^PN\\d{2}\\.txt", full.names = TRUE)
out2004 <- list()

for (i in seq_along(files2004)) {
  message(sprintf("Processing %s", files2004[i]))
  out2004[[i]] <- read.table(
    file = files2004[i],
    header = FALSE,
    sep = "$",
    fileEncoding = "Windows-1250")
}
pn2004 <- do.call(rbind, out2004)
colnames(pn2004) <- colnames.95

pn2004 <- rbind(pn2000, pn2004)

files2021 <- list.files(path = "data", pattern = "^pn\\d{4}\\.csv$", full.names = TRUE)
out2021 <- list()

for (i in seq_along(files2021)) {
  message(sprintf("Processing %s", files2021[i]))
  out2021[[i]] <- read.table(
    file = files2021[i],
    header = TRUE,
    sep = ";",
    fileEncoding = "Windows-1250")
}

pn2021 <- do.call(rbind, out2021)

save(pn2004, pn2021, file = "./data/raw_accident_data_1995_2021.RData")
