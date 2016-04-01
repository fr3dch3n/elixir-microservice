ExUnit.start

Mix.Task.run "ecto.create", ~w(-r MagellanMicroservice.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r MagellanMicroservice.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(MagellanMicroservice.Repo)

