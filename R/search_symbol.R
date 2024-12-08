#' @usage search_symbol(search_text)
#' @name search_symbol
#' @export search_symbol
#' @title search_symbol
#' @description Search for the symbol of an economic data series that matches the `search_text`.
#' @param search_text, character containing the words with which you expect to find the id of the variable.
#' @param api_key, character specyfing the api key for FRED
#' @examples search_symbol("Exports Mexico")
#' @examples search_symbol("GDP Germany")
#' @examples search_symbol("GNP France")
search_symbol <- function(search_text, api_key = getOption("API_KEY_FRED")) {
  url <- "https://api.stlouisfed.org/fred/series/search"
  parameters <- list(
    "api_key" = api_key,
    "file_type" = "json",
    "search_text" = search_text
  )

  response <-
    httr::GET(url, query = parameters) |>
    httr::content(as = "parsed") |>
    purrr::pluck("seriess")

  symbols <-
    tibble::tibble(
      symbol = response |> purrr::map_vec("id"),
      popularity = response |> purrr::map_vec("popularity"),
      title = response |> purrr::map_vec("title")
    ) |>
    dplyr::arrange(dplyr::desc(popularity))

  return(symbols)
}
