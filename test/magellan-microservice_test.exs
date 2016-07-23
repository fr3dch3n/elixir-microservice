defmodule MagellanMicroservice.Test do
  use ExUnit.Case, async: true

  test "ensure everything gets started up" do
    assert Application.ensure_all_started(:magellan_microservice) == {:ok, []}
  end
end
