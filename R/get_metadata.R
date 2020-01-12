#' @usage get_metadata(symbol)
#' @name get_metadata
#' @export get_metadata
#' @title get_metadata
#' @description Get information about a time series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @examples get_metadata("GDPC1")
#' @examples get_metadata("FEDFUNDS")
#' @examples get_metadata("T10Y2Y")
get_metadata <- function(symbol) {

  url = "https://api.stlouisfed.org/fred/series"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "series_id" = symbol
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")
  results <- response$seriess[[1]]

  print("")
  print(paste0("Metadata for: ", symbol))
  print(paste0("Title: ", results["title"]))
  print(paste0("Units: ", results["units"]))
  print(paste0("Adjustment: ", results["seasonal_adjustment"]))
  print(paste0("Frequency: ", results["frequency"]))
  print(paste0("Notes: ", results["notes"]))

  return(results)

}
