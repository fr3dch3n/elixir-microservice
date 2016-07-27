# Magellan-Microservice [![Hex.pm](https://img.shields.io/badge/magellan--microservice-v0.1.5-orange.svg)](https://hex.pm/packages/magellan_microservice)

[![Build Status](https://travis-ci.org/fr3dch3n/magellan-microservice.svg?branch=master)](https://travis-ci.org/fr3dch3n/magellan-microservice)[![Inline docs](http://inch-ci.org/github/fr3dch3n/magellan-microservice.png)](http://inch-ci.org/github/fr3dch3n/magellan-microservice)


This is a simple Microservice written in Elixir.
The Magellan-Microservice provides a basic app-status and health page.
It also provides the possibility to plug in a custom router.

**Documentation** can be found [here](https://hexdocs.pm/magellan_microservice/api-reference.html).

## Installation

Add the following line to your mix.exs deps:
```
{:magellan_microservice, "0.1.5"}
```


## Example

To start the Microserice, just add it to the applications in your mix.exs.
```
 def application do
    [applications: [:magellan_microservice],
    mod: {Your.App, []}]
  end
```

To use your custom plug-router, register it at start-up time.
```
MagellanMicroservice.Router.register_router(Example.Router)
```

To add a status-function to the app-status, just pass it to: `register_status_fun`.
```
MagellanMicroservice.AppStatus.register_status_fun(:name, &your_status_fun/0)
```


## Configuration

The following configuration has to be provided.
```
config :magellan_microservice,
  status: "/status",
  health: "/health",
  port: 8080
```


## Test

To run the test, you need to provide the `PORT` as an env-variable.
```
PORT=9121 mix test
```