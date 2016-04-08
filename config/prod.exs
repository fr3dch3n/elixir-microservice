use Mix.Config

config :magellan_microservice,
  port: 8082

  config :logger,
    level: :info,
    truncate: 4096
