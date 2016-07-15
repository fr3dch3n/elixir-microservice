use Mix.Config

# Print only warnings and errors during test
config :logger,
  level: :warn

config :magellan_microservice,
  status: "/test/status",
  health: "/test/health"

config :magellan_microservice,
  port: 6060
