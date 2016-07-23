defmodule MagellanMicroservice.Server.Test do
  use ExUnit.Case, async: true
  alias MagellanMicroservice.Server

    test "check if reading from env var does work" do
      assert Server.specify_port == 9121
    end
    test "simple server status function" do
      assert Server.status == %{status: :ok}
    end
end
