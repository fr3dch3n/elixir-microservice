defmodule MagellanMicroservice.Mixfile do
  use Mix.Project

  def project do
    [app: :magellan_microservice,
     version: "0.1.8",
     elixir: "~> 1.2",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {MagellanMicroservice, []},
      applications: [:cowboy, :plug, :poison, :logger]]
  end

  defp description do
    """
    A basic microservice in Elixir.
    It contains a server with easy to expand router, as well as an application-status with http-endpoint.
    """
  end

  defp package do
    [
       licenses: ["Apache 2.0"]
    ]
  end

  def deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:ex_doc, "~> 0.12", only: :dev},
      {:inch_ex, only: :dev}
    ]
  end
end
