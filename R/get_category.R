#' @usage get_category(symbol)
#' @name get_category
#' @export get_category
#' @title get_category
#' @description Get the categories for an economic data series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @examples get_category("GDPC1")
#' @examples get_category("FEDFUNDS")
#' @examples get_category("T10Y2Y")
get_category <- function(symbol) {

  url = "https://api.stlouisfed.org/fred/series/categories"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "series_id" = symbol
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")
  body <- response$categories[[1]]$name

  return(body)

}
