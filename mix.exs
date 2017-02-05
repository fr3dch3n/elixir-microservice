defmodule MagellanMicroservice.Mixfile do
  use Mix.Project

  def project do
    [app: :magellan_microservice,
     version: "0.1.10",
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
      {:plug, "~> 1.3"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.14.5", only: :dev},
    ]
  end
end
