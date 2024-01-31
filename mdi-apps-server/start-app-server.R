# set environment variable to honor system library in server images
Sys.setenv(MDI_SYSTEM_R_LIBRARY = "/usr/local/lib/R/site-library")

# launch the web server
mdi::run(
  mdiDir = Sys.getenv("MDI_DIR"),
  dataDir = NULL,
  hostDir = NULL,
  mode = "server",
  install = TRUE,
  url = paste0("https://", Sys.getenv("WEB_DOMAIN"), "/"),
  port = 3838, # reverse proxy responds on 443, R responds on 3838 on the docker public-server network # nolint
  browser = FALSE,
  debug = as.logical(Sys.getenv("IS_DEBUG")),
  developer = as.logical(Sys.getenv("IS_DEVELOPER")) # never TRUE on a public server
)
