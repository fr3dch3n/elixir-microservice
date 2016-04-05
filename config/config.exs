use Mix.Config

config :router,
  app_router: ElixirMicroservice.NewRouter

import_config "#{Mix.env}.exs"
