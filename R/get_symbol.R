#' @usage get_symbol(symbol)
#' @name get_symbol
#' @export get_symbol
#' @title get_symbol
#' @description Download data from FRED.
#' @param symbol, character denoting the symbol to download, e.g. "GDPC1" or "FEDFUNDS"
#' @param api_key, character specyfing the api key for FRED
#' @examples get_symbol("GDPC1")
#' @examples get_symbol("T10Y2Y")
#' @examples c("FEDFUNDS", "GDPC1") |> map(get_symbol)
get_symbol <- function(symbol, api_key = getOption("API_KEY_FRED")) {
  if (api_key == "") stop("'api_key' is not set")
  url <- "https://api.stlouisfed.org/fred/series/observations"
  parameters <- list(
    "api_key" = api_key,
    "file_type" = "json",
    "series_id" = symbol
  )
  response <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed")
  if (!is.null(response$error_code) && response$error_code == 400) {
    stop(response$error_message)
  }
  observations <-
    response |>
    purrr::pluck("observations")

  data <-
    tibble::tibble(
      date = observations |> purrr::map_vec("date") |> as.Date(),
      symbol = symbol,
      title = search_symbol("GDPC1")$title,
      value = observations |> purrr::map_vec("value") |> as.numeric(),
      units = response$units
    ) |>
    dplyr::arrange(date, symbol)
  return(data)
}
