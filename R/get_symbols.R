#' @usage get_symbols(symbol)
#' @name get_symbols
#' @export get_symbols
#' @title get_symbols
#' @description Download data from FRED.
#' @param symbol symbol, e.g. "GDPC1" or "FEDFUNDS"
#' @examples get_symbols("GDPC1")
#' @examples get_symbols("FEDFUNDS")
#' @examples get_symbols("T10Y2Y")
get_symbols <- function(symbol) {

  url <- "https://api.stlouisfed.org/fred/series/observations"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "series_id" = symbol
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")$observations

  if (is.null(response)) stop("The specified symbol does not exist")

  x <- xts::xts(x = as.numeric(unlist(purrr::map(response, 4))),
                order.by = as.Date(unlist(purrr::map(response, 3))),
                origin = "1970-01-01")

  return(x)

}
