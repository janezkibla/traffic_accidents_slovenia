#' Download police traffic accidents data
#' 
#' Using this function you can fetch traffic accidents data
#' from policija.si website in a simple manner. Specify year
#' and magic happens.
#' 
#' @param year Integer or character, i.e. 1995 or "1995"
#' @param folder Relative or absolute path to folder where data will be
#' downloaded to, i.e. "data"
#' @return Path to downloaded file
pnDataDownloader <- function(year, folder = "data") {
  custom.url <- paste("https://www.policija.si/baza/pn", year, ".zip", sep = "")
  pn <- basename(custom.url)
  pn <- file.path(folder, pn)
  
  download.file(url = custom.url, destfile = pn)
  
  return(pn)
}

#' Extracts year from a path. This usually looks like
#' data/pnXXXX.csv. The XXXX part is extracted and converted
#' to integer.
#' @param x Path string.
extractYear <- function(x) {
  bn <- basename(x)
  year <- gsub("pn(\\d+)\\.csv", replacement = "\\1", x = bn)
  year <- as.integer(year)

  return(year)
}

#' Given a list of years and encodings, find the corresponding
#' year.
#' @param year Integer. Find encoding for this year.
findEncoding <- function(year) {
  loe  <- list(
    "UTF-8" = 1995:2004,
    "Windows-1250" = 2005:2023
  )

  find.enc <- sapply(loe, FUN = "==", year)
  find.enc <- sapply(find.enc, FUN = any)
  find.enc <- find.enc[find.enc]

  if (length(find.enc) > 1) {
    stop("List of encodings includes one year under two encodings. This
    is not compatible. Please check loe in findEncoding().")
  }

  return(names(find.enc))
}