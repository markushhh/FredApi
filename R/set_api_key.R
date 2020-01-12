set_api_key <- function(api_key) {
  if (length(Sys.getenv("API_FRED")) > 1) {
    message(paste0("Your API key is: ", Sys.getenv("API_FRED")))
  } else {
    Sys.setenv("API_FRED" = api_key)
  }
  return(invisible(api_key))
}
