# Magellan-Microservice

This is a simple Microservice written in Elixir.
The Magellan-Microservice provides a basic app-status and health page.
It also provides the possibility to plug in a custom router (see Examples).

## Installation

Add the following line to your mix.exs deps:
'{:magellan_microservice, git: "https://github.com/fr3dch3n/magellan-microservice", branch: :master, app: false}'

## Example

To start the Microserice, start it as a supervisor next to your app.
'''
def init([]) do
  children = [
    supervisor(MagellanMicroservice.Core, []),
    supervisor(Example.Core, [])
  ]
  supervise(children, strategy: :one_for_one)
end
'''

To use your custom plug-router, register it at start-up time.
'''
MagellanMicroservice.Router.register_router(Example.Router)
'''

The following configuration has to be provided.
'''
config :magellan_microservice,
  status: "/status",
  health: "/health",
  port: 8080
'''