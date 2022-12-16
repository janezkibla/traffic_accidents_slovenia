library(suncalc)

load("./data/raw_accident_data_1995_2021.RData")

convertToTime <- function(x) {
  sp <- strsplit(x, split = ".", fixed = TRUE)[[1]]
  
  if (length(sp) > 1) {
    if (nchar(sp[[2]]) < 2) {
      sp[[2]] <- sprintf("%s0", sp[[2]])
    }
  } else {
    sp[[2]] <- "00"
  }
  
  do.call(paste, args = list(sp, collapse = ":"))
}

pn2004$datum <- 
  as.POSIXlt(
    paste(
      pn2004$datum, 
      sapply(as.character(pn2004$ura), FUN = convertToTime)
    ), 
    format = "%d.%m.%Y %H:%M"
  )
pn2004$ura <- NULL
pn2004 <- pn2004[!is.na(pn2004$datum), ]

sun <- getSunlightTimes(
  date = as.Date(pn2004$datum),
  lat = 46.119553,
  lon = 14.838006
)
pn2004$dan_noc <- ifelse(
  pn2004$datum > sun$sunrise & pn2004$datum < sun$sunset,
  yes = "day",
  no = "night"
)

pn2021$datum <- 
  as.POSIXlt(
    paste(
      pn2021$DatumPN, 
      sapply(as.character(pn2021$UraPN), FUN = convertToTime)
    ), 
    format = "%d.%m.%Y %H:%M"
  )
pn2021$UraPN <- NULL

sun <- getSunlightTimes(
  date = as.Date(pn2021$datum),
  lat = 46.119553,
  lon = 14.838006
)

pn2021$dan_noc <- ifelse(
  pn2021$datum > sun$sunrise & pn2021$datum < sun$sunset, 
  yes = "day", 
  no = "night"
)

prop.table(table(pn2004$dan_noc))
prop.table(table(pn2021$dan_noc))

save(pn2004, pn2021, file = "data/pn_data_day_night.RData")
