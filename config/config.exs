use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n"

config :magellan_microservice,
    status: "/status",
    health: "/health"

config :logger,
    level: :info,
    truncate: 4096

import_config "#{Mix.env}.exs"
