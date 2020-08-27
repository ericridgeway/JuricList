defmodule Pre8RestartTest.Database do
  use ExUnit.Case

  alias Pre8Restart.{Database}

  setup do
    Database.start()

    on_exit fn ->
      Database.clear()
    end
  end

  test "Database store and get" do
    :ok = Database.store(:cat, :meow)
    :ok = Database.store(:cat, "doggy")
    :ok = Database.store("asd123", "abed is batman")

    assert Database.get(:cat) == "doggy"
    assert Database.get("asd123") == "abed is batman"
  end

  test "Database is clean between tests" do
    assert Database.get(:cat) == nil
  end
end
