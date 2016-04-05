use Mix.Config
alias MagellanMicroservice.Server.Router

config :microservice,
app_router: MagellanMicroservice.NewRouter

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n"

config :logger,
  level: :info,
  truncate: 4096

import_config "#{Mix.env}.exs"
