defmodule MagellanMicroservice.Config do
  require Logger

  def start_link() do
    Logger.info "--> starting the magellan-config"
    verify_config

    {:ok, self}
  end

  def verify_config() do
    missing_keys = [:port]
    |> Enum.filter(fn(x) ->
      try do
        !Application.fetch_env!(:magellan_microservice, x)
      rescue
        _ in ArgumentError -> -1
      end
    end)
    if Enum.empty?(missing_keys) do
      Logger.info "Config for magellan-microservice was provided. Continue.."
    else
      Logger.error "The following keys are missing in the config: "
      IO.inspect missing_keys
      exit({:shutdown, "Configuration is incomplete."})
    end
  end
end
