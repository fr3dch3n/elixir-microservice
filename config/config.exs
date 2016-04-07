use Mix.Config


config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n"

  config :logger,
    level: :info,
    truncate: 4096


import_config "#{Mix.env}.exs"
