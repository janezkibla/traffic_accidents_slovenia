library(ggplot2)

dir.create("figures", showWarnings = FALSE)

load("./data/raw_accident_data_1995_2021.RData")

pn2004$datum <- as.Date(pn2004$datum, format = "%d.%m.%Y")
pn2021$DatumPN <- as.Date(pn2021$DatumPN, format = "%d.%m.%Y")

pn2021$VrednostAlkotesta <- as.numeric(gsub(",", replacement = "\\.", x = pn2021$VrednostAlkotesta))

pn2021$VozniskiStalez <- ((pn2021$VozniskiStazVLetih * 12) + pn2021$VozniskiStazVMesecih) / 12

# These NAs result due to incomplete final line in each file.
pn2004 <- pn2004[!is.na(pn2004$datum), ]

pn2004$year <- strftime(pn2004$datum, format = "%Y")
pn2021$year <- strftime(pn2021$DatumPN, format = "%Y")

# Remove unknown gender/sex.
pn2021 <- pn2021[pn2021$Spol %in% c("MOŠKI", "ŽENSKI"), ]

ggplot(
  data = pn2021,
  mapping = aes(x = Spol, y = Starost)
) +
  theme_bw() +
  geom_violin() +
  geom_jitter(width = 0.1, alpha = 0.05) +
  facet_wrap(~KlasifikacijaNesrece)
ggsave("figures/figure-0-accidents-by-gender-and-severity.png", 
       width = 1000, height = 1000, units = "px", dpi = 150)

pn2021.kolo <- pn2021[pn2021$VrstaUdelezenca == "KOLESAR", ]

ggplot(
  data = pn2021.kolo,
  mapping = aes(x = Povzrocitelj, y = Starost)
) +
  theme_bw() +
  geom_violin() +
  geom_jitter(width = 0.1, alpha = 0.1) +
  facet_wrap(~PoskodbaUdelezenca)
ggsave("figures/figure-1-cyclists-age-structure-by-severity.png", 
       width = 1000, height = 1000, units = "px", dpi = 150)

table(pn2021$VrstaUdelezenca, pn2021$Povzrocitelj)

table(pn2021$VrstaUdelezenca, pn2021$PoskodbaUdelezenca)

table(pn2021$PoskodbaUdelezenca, pn2021$UporabaVarnostnegaPasu, pn2021$VrstaUdelezenca)

pn2021.alko <- pn2021[pn2021$VrednostAlkotesta > 0, ]
ggplot(
  data = pn2021.alko,
  mapping = aes(x = VrednostAlkotesta, y = VozniskiStalez)
) +
  theme_bw() +
  geom_point(alpha = 0.25)
