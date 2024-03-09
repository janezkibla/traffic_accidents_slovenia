source("functions.R")
INPUT.DATA <- "data"
RAW.RDATA <- file.path("data", "raw_accident_data.RData")

input.csvs <- list.files(
  path = INPUT.DATA,
  pattern = "^pn\\d{4}\\.csv$",
  full.names = TRUE
)

impoted.csv <- list()
for (i in seq_along(input.csvs)) {
  ss <- input.csvs[i]
  message(sprintf("Processing %s", ss))

  enk <- findEncoding(year = extractYear(ss))

  impoted.csv[[i]] <- read.table(
    file = ss,
    header = TRUE,
    sep = ";",
    fileEncoding = enk)
}

message("Merging imported csvs into a single data.frame")
raw.accident.data <- do.call(rbind, impoted.csv)

message(sprintf("Saving data into %s", RAW.RDATA))
save(raw.accident.data, file = RAW.RDATA)
