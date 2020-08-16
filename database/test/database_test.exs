defmodule DatabaseTest do
  use ExUnit.Case

  test "Basic store and retrieve, not testing thru server crash yet" do
    {:ok, _database} = Database.start()

    :ok = Database.store(:abed, "is batman")
    assert Database.get(:abed) == "is batman"
  end
end
