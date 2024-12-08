#' @usage press_release_link(symbol)
#' @name press_release_link
#' @export press_release_link
#' @title press_release_link
#' @description Get release information for an economic data series in the FRED database.
#' @param symbol String specifying the name (id) of the time series.
#' @examples press_release_link("GDPC1")
#' @examples press_release_link("FEDFUNDS")
#' @examples press_release_link("T10Y2Y")
press_release_link <- function(symbol, api_key = getOption("API_KEY_FRED"))) {
  if (api_key == "") stop("'api_key' is not set")
  url <- "https://api.stlouisfed.org/fred/series/release"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "series_id" = symbol
  )

  link <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed") |>
    purrr::pluck("releases") |>
    dplyr::first() |>
    purrr::pluck("link")

  return(link)
}
