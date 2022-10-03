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

