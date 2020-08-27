defmodule Pre8RestartTest.Database do
  use ExUnit.Case

  alias Pre8Restart.{Database}

  setup do
    on_exit fn ->
      Database.clear(Database.new())
    end
  end

  test "Database store and get" do
    database =
      Database.new()
      |> Database.store(:cat, :meow)
      |> Database.store(:cat, "doggy")
      |> Database.store("asd123", "abed is batman")

    assert Database.get(database, :cat) == "doggy"
    assert Database.get(database, "asd123") == "abed is batman"
  end

  test "Database is clean between tests" do
    # database =
      Database.new()
      Database.new()
      Database.new()
    #   |> Database.store(:cat, "doggy")

    database =
      Database.new()

    assert Database.get(database, :cat) == nil
  end
end
