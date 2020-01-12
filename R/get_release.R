#' @usage get_release(symbol)
#' @name get_release
#' @export get_release
#' @title get_release
#' @description Get release information for an economic data series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @examples get_release("GDPC1")
#' @examples get_release("FEDFUNDS")
#' @examples get_release("T10Y2Y")
get_release <- function(symbol) {

  url = "https://api.stlouisfed.org/fred/series/release"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "series_id" = symbol
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")

  x <- response$releases[[1]]

  return(x)

}
