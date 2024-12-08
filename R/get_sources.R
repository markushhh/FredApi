#' @usage get_sources()
#' @name get_sources
#' @export get_sources
#' @title get_sources
#' @description Get all sources of economic data.
#' @param api_key, character specyfing the API for FRED
#' @examples get_sources()
get_sources <- function(api_key = getOption("API_KEY_FRED")) {
  url <- "https://api.stlouisfed.org/fred/sources"
  parameters <- list(
    "api_key" = api_key,
    "file_type" = "json"
  )

  response <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed") |>
    purrr::pluck("sources")

  sources <-
    tibble::tibble(
      id   = response |> purrr::map_vec("id"),
      name = response |> purrr::map_vec("name")
    )

  return(sources)
}
