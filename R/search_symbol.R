#' @usage search_symbol(search_text, must_contain)
#' @name search_symbol
#' @export search_symbol
#' @title search_symbol
#' @description Search for the symbol of an economic data series that matches the search text.
#' @param search_text A string containing the words with which you expect to find the id of the variable.
#' @param must_contain A string like "Germany" to explicitly search for a variable which contains "Germany" in its title
#' @examples search_symbol("Exports", "Mexico")
#' @examples search_symbol("GDP", "Germany")
#' @examples search_symbol("G", "France")
#' @examples x <- search_symbol("Exports", "Mexico")
#' @examples print(x)
search_symbol <- function(search_text, must_contain = "") {

  search_text <- gsub(" ", "+", search_text, fixed = TRUE)
  must_contain <- gsub(" ", "+", must_contain, fixed = TRUE)

  url = "https://api.stlouisfed.org/fred/series/search"
  parameters <- list(
    "api_key" = Sys.getenv("API_FRED"),
    "file_type" = "json",
    "search_text" = search_text
  )

  response <- httr::content(httr::GET(url, query = parameters), as = "parsed")
  l = response$seriess

  ll <- which(stringi::stri_detect_fixed(unlist(purrr::map(l, 4)), must_contain))
  l <- l[ll]

  x <- data.frame(popularity = unlist(purrr::map(l, 14)),
             id = unlist(purrr::map(l, 1)),
             title = unlist(purrr::map(l, 4))
  )
  x <- x[order(x$popularity, decreasing = TRUE), ]

  return(x)

}
