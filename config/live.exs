use Mix.Config

config :microservice,
  port: 8080

  config :logger,
    level: :info,
    truncate: 4096
