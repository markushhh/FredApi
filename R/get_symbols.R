#' @usage get_symbols(symbol)
#' @name get_symbols
#' @export get_symbols
#' @title get_symbols
#' @description Download data from FRED.
#' @param symbol symbol, e.g. "GDPC1" or "FEDFUNDS"
#' @param api_key character specyfing the API for FRED
#' @examples get_symbols("GDPC1")
#' @examples get_symbols("T10Y2Y")
#' @examples get_symbols("FEDFUNDS", "T10Y2Y")
get_symbols <- function(symbols, api_key = Sys.getenv("API_FRED")) {
  get_symbol <- function(symbol, api_key = Sys.getenv("API_FRED")) {
    url <- "https://api.stlouisfed.org/fred/series/observations"
    parameters <- list(
      "api_key" = api_key,
      "file_type" = "json",
      "series_id" = symbol
    )

    response <-
      httr::GET(url, query = parameters) |>
      httr::content(as = "parsed") |>
      purrr::pluck("observations")

    if (is.null(response)) {
      warning("The specified symbol '", symbol, "' does not exist")
    }

    data <-
      tibble::tibble(
        date = response |> purrr::map("date") |> unlist() |> as.Date(),
        symbol = symbol,
        values = response |> purrr::map("value") |> unlist() |> as.numeric()
      ) |>
      dplyr::arrange(date)

    return(data)
  }

  data <-
    symbols |>
    purrr::map(\(symbol) get_symbol(symbol)) |>
    purrr::reduce(dplyr::full_join, by = c("date", "symbol", "values"))

  return(data)
}
