use Mix.Config

config :router,
  p: "/hi"

import_config "#{Mix.env}.exs"
