use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n"

config :magellan_microservice,
  status: "/status",
  health: "/health"

config :logger,
  level: :info,
  truncate: 4096

config :prometheus, MagellanMicroservice.PipelineInstrumenter,
    labels: [:status_class, :method, :host, :scheme, :request_path],
    duration_buckets: [10, 100, 1_000, 10_000, 100_000,
                       300_000, 500_000, 750_000, 1_000_000,
                       1_500_000, 2_000_000, 3_000_000],
    registry: :default,
    duration_unit: :microseconds

import_config "#{Mix.env}.exs"
