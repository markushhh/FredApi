#' @usage get_sources()
#' @name get_sources
#' @export get_sources
#' @title get_sources
#' @description Get all sources of economic data.
#' @examples get_sources()
get_sources <- function() {

  url = "https://api.stlouisfed.org/fred/sources"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json"
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")
  l = response$sources

  x = data.frame(id = unlist(purrr::map(l, 1)),
             name = unlist(purrr::map(l, 4)))

  return(x)

}
