# Script for downloading Slovenian police data. 

# Skript za prenesti podatke o prometnih nesrečah.  

source("functions.R")
dir.create("data", showWarnings = FALSE)

for (i in 1995:2023) {
  pnDataDownloader(year = i)
}

zip_file <- list.files(path = "./data", pattern = "*.zip", full.names = TRUE)

for(i in zip_file) {
  unzip(zipfile = i, exdir = "./data")
}
