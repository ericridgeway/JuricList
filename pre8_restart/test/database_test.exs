defmodule Pre8RestartTest.Database do
  use ExUnit.Case

  alias Pre8Restart.{Database}

  test "Database store and get" do
    database =
      Database.new()
      |> Database.store(:cat, :meow)
      |> Database.store(:cat, "doggy")
      |> Database.store("asd123", "abed is batman")

    assert Database.get(database, :cat) == "doggy"
    assert Database.get(database, "asd123") == "abed is batman"
  end
end
