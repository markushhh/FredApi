#' @usage get_metadata(symbol)
#' @name get_metadata
#' @export get_metadata
#' @title get_metadata
#' @description Get information about a time series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @param api_key character specyfing the API for FRED
#' @examples get_metadata("GDPC1")
#' @examples get_metadata("FEDFUNDS")
#' @examples get_metadata("T10Y2Y")
get_metadata <- function(symbol, api_key = Sys.getenv("API_FRED")) {
  url <- "https://api.stlouisfed.org/fred/series"
  parameters <- list(
    "api_key" = api_key,
    "file_type" = "json",
    "series_id" = symbol
  )

  response <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed") |>
    purrr::pluck("seriess") |>
    dplyr::first()

  return(response)
}
