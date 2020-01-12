#' @usage get_source(source_id)
#' @name get_source
#' @export get_source
#' @title get_source
#' @description Get the source of a specific time series.
#' @param source_id an ID, e.g. 1 for "Board of Governors of the Federal Reserve System (US)"
#' @examples get_source(1)
#' @examples get_source(3)
#' @examples get_source(4)
get_source <- function(source_id) {

  url = "https://api.stlouisfed.org/fred/sources"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "source_id" = source_id
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")
  x <- response$sources[source_id][[1]]

  return(x)

}
