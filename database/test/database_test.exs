defmodule DatabaseTest do
  use ExUnit.Case

  test "TODO" do
    {:ok, _database} = Database.start()

    :ok = Database.store(:abed, "is batman")
    assert Database.get(:abed) == "is batman"
  end
end
