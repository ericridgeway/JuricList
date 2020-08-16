defmodule DatabaseTest do
  use ExUnit.Case

  setup do
    # {:ok, _database} = Database.start()
    Database.start()

    :ok
  end

  test "Basic store and retrieve, not testing thru server crash yet" do
    :ok = Database.store(:abed, "is batman")
    :ok = Database.store("asd", "morning")

    assert Database.get(:abed) == "is batman"
    assert Database.get("asd") == "morning"
  end

  test "Delete key" do
    :ok = Database.store(:troy, "morning")
    :ok = Database.delete(:troy)

    assert Database.get(:troy) == nil
  end
end
