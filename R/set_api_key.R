#' @usage set_api_key(api_key)
#' @name set_api_key
#' @export set_api_key
#' @title set_api_key
#' @description Set API_KEY for downloading FRED data.
#' @param api_key character specyfing the API for FRED
#' @examples set_api_key("123121")
set_api_key <- function(api_key) {
  if (Sys.getenv("API_FRED") != "") {
    message(paste0("API_FRED was already set to: ", Sys.getenv("API_FRED")))
    message("overwriting API_FRED to: ", api_key)
  } else {
  }
  Sys.setenv("API_FRED" = api_key)
  return(invisible(api_key))
}
