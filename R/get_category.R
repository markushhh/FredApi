#' @usage get_category(symbol)
#' @name get_category
#' @export get_category
#' @title get_category
#' @description Get the categories for an economic data series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @param api_key character specyfing the API for FRED
#' @examples get_category("GDPC1")
#' @examples get_category("FEDFUNDS")
#' @examples get_category("T10Y2Y")
get_category <- function(symbol, api_key = getOption("API_KEY_FRED")) {
  url <- "https://api.stlouisfed.org/fred/series/categories"
  parameters <- list(
    "api_key" = api_key,
    "file_type" = "json",
    "series_id" = symbol
  )

  category <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed") |>
    purrr::pluck("categories") |>
    dplyr::first() |>
    purrr::pluck("name")

  return(category)
}
