defmodule ElixirMicroservice.Mixfile do
  use Mix.Project

  def project do
    [app: :microservice,
     version: "0.0.1",
     elixir: "~> 1.2",
    #  escript: [main_module: Microservice],
     build_embedded: Mix.env == :dev,
     start_permanent: Mix.env == :dev,
     deps: deps]
  end

  def application do
    [mod: {ElixirMicroservice.Core, []},
      applications: [:cowboy, :plug, :poison, :poolboy, :redix, :kafka_ex]]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:redix, ">= 0.0.0"},
      {:poolboy, "~> 1.5" },
      {:kafka_ex, "~> 0.5.0"}
    ]
  end
end
