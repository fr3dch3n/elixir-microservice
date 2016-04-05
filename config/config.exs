use Mix.Config
alias ElixirMicroservice.Server.Router

config :microservice,
app_router: ElixirMicroservice.NewRouter

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n"

config :logger,
  level: :info,
  truncate: 4096

import_config "#{Mix.env}.exs"
