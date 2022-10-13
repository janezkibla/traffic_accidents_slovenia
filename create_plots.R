library(ggplot2)

load("./data/raw_data_1995_2021.RData")

result05$DatumPN <- as.Date(result05$DatumPN, format = "%d.%m.%Y")

ggplot(data = result05,
       mapping = aes(x = Starost)) +
  geom_histogram()

ggplot(data = result05, 
       mapping = aes(x = DatumPN, y = 1)) + 
  geom_point() + 
  facet_wrap(~KlasifikacijaNesrece)
