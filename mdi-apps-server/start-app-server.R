# launch the web server
mdi::run(
  mdiDir = Sys.getenv('MDI_DIR'),
  dataDir = NULL,
  hostDir = NULL,
  mode = "server",
  install = TRUE,
  url = paste0("https://", Sys.getenv('WEB_DOMAIN'), '/'),
  port = 3838, # reverse proxy responds on 443, R responds on 3838 on the docker public-server network
  browser = FALSE,
  debug = as.logical(Sys.getenv('IS_DEBUG')),
  developer = FALSE # !! must never be TRUE on a public server !!
)
