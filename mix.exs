defmodule MagellanMicroservice.Mixfile do
  use Mix.Project

  def project do
    [app: :magellan_microservice,
     version: "0.1.12",
     elixir: "~> 1.4.1",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {MagellanMicroservice, []},
      applications: [:cowboy, :plug, :poison, :logger, :prometheus, :prometheus_ex, :prometheus_plugs]]
  end

  defp description do
    """
    A basic microservice in Elixir.
    It contains a server with easy to expand router, as well as an application-status with http-endpoint.
    """
  end

  defp package do
    [
       licenses: ["Apache 2.0"],
       name: :magellan_microservice,
       maintainers: ["Frederik Mars"],
       links: %{"GitHub" => "https://github.com/fr3dch3n/magellan-microservice",
                "Docs" => "https://hexdocs.pm/magellan_microservice/api-reference.html"}
    ]
  end

  def deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:prometheus_plugs, "~> 1.1"},
      {:prometheus_ex, "~> 1.3"},
      {:ex_doc, "~> 0.16.2", only: :dev},
      {:inch_ex, "~> 0.5.6", only: [:dev, :test]}
    ]
  end
end
