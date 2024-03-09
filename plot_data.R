library(ggplot2)

dir.create("figures", showWarnings = FALSE)

load(file.path("data", "raw_accident_data.RData"))

rad <- raw.accident.data
rm(raw.accident.data)

rad$DatumPN <- as.Date(rad$DatumPN, format = "%d.%m.%Y")

rad$VrednostAlkotesta <- as.numeric(
  gsub(",", replacement = "\\.", x = rad$VrednostAlkotesta)
)

rad$VozniskiStalez <- ((rad$VozniskiStazVLetih * 12) + rad$VozniskiStazVMesecih) / 12

# These NAs result due to incomplete final line in each file.
rad$year <- strftime(rad$DatumPN, format = "%Y")

# Remove unknown gender/sex.
rad <- rad[rad$Spol %in% c("MOŠKI", "ŽENSKI"), ]

ggplot(
  data = rad,
  mapping = aes(x = Spol, y = Starost)
) +
  theme_bw() +
  geom_violin() +
  geom_jitter(width = 0.1, alpha = 0.05) +
  facet_wrap(~KlasifikacijaNesrece)

ggsave(
  file.path("figures", "figure-0-accidents-by-gender-and-severity.png"),
       width = 1000, height = 1000, units = "px", dpi = 150)

kolo <- rad[rad$VrstaUdelezenca == "KOLESAR", ]

ggplot(
  data = kolo,
  mapping = aes(x = Povzrocitelj, y = Starost)
) +
  theme_bw() +
  geom_violin() +
  geom_jitter(width = 0.1, alpha = 0.1) +
  facet_wrap(~PoskodbaUdelezenca)

ggsave(file.path("figures", "figure-1-cyclists-age-structure-by-severity.png"),
  width = 1000, height = 1000, units = "px", dpi = 150)

table(rad$VrstaUdelezenca, rad$Povzrocitelj)

table(rad$VrstaUdelezenca, rad$PoskodbaUdelezenca)

table(rad$PoskodbaUdelezenca, rad$UporabaVarnostnegaPasu, rad$VrstaUdelezenca)

alko <- rad[rad$VrednostAlkotesta > 0, ]
ggplot(
  data = alko,
  mapping = aes(x = VozniskiStalez, y = VrednostAlkotesta)
) +
  theme_bw() +
  geom_point(alpha = 0.05) +
  facet_wrap(~ Spol)

ggsave(file.path("figures", "figure-2-experience-alcohol-gender.png"),
width = 1000, height = 600, units = "px", dpi = 150)

smrt <- rad[rad$KlasifikacijaNesrece %in% "SMRT", ]

ggplot(
  data = smrt,
  mapping = aes(x = Spol, y = Starost)
) +
theme_bw() +
geom_violin() +
geom_jitter(alpha = 0.25, width = 0.1)

ggplot(
  data = smrt,
  mapping = aes(x = Starost, fill = Spol)
) +
theme_bw() +
theme(legend.position = "top") +
ylab("Število") +
xlab("Starost") +
scale_fill_manual(values = c("darkgrey", "lightgrey")) +
geom_histogram()

ggsave(file.path("figures", "figure-3-death-by-gender-and-age.png"),
width = 600, height = 600, units = "px", dpi = 150)
