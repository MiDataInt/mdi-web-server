
magc.portal::run(
  portalDir = "/srv/magc-portal", # a fixed value in the app-server container
  url = paste0("https://", Sys.getenv('WEB_DOMAIN'), '/'), # do not include port; reverse proxy responds on 443
  mode = "server",
  browser = FALSE,
  debug = FALSE,
  developer = FALSE # !! must never be TRUE on a public server !!
)

