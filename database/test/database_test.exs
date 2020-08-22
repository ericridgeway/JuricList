defmodule DatabaseTest do
  use ExUnit.Case

  setup do
    # {:ok, _database} = Database.start()
    Database.start()

    :sys.get_state(Database)
    |> IO.inspect(label: "")

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

# TODO next Finish the bk thing of using 3 worker pids instead of just 1. Should be easy
#   Note, Don't think I can add a test. I think just "refactor" and everything still works should be fine
# TODO next ok, I might go back to GenServer's in 1 file. Keep the impl in seperate file and call it State instead of impl
