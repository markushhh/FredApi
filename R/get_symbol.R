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

  title <- search_symbol(symbol) |> pull(title)

  get_frequency <- function(data) {
    x <- data |>
      dplyr::pull(date) |>
      diff() |>
      dplyr::first()
    frequency <- dplyr::case_when(
      x %in% c(365, 366) ~ "yearly",
      x %in% c(88, 89, 90, 91, 92) ~ "quarterly",
      x %in% c(28, 29, 30, 31) ~ "monthly",
      x %in% c(1) ~ "daily"
    )
    return(frequency)
  }

  data <-
    tibble::tibble(
      date = observations |> purrr::map_vec("date") |> as.Date(),
      symbol = symbol,
      title = title,
      value = observations |> purrr::map_vec("value") |> as.numeric(),
      units = response$units
    ) |>
    dplyr::arrange(date, symbol)
  data <- data |> dplyr::mutate(frequency = get_frequency(data))
  return(data)
}
