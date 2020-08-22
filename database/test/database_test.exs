defmodule DatabaseTest do
  use ExUnit.Case

  setup do
    # {:ok, _database} = Database.start()
    Database.start()

    :ok
  end

  test "Basic store and retrieve, not testing thru server crash yet" do
    :ok = Database.store(:abed, "is batman")
    :ok = Database.store("asd123", "morning")

    assert Database.get(:abed) == "is batman"
    assert Database.get("asd123") == "morning"
  end

  test "Delete key" do
    :ok = Database.store(:troy, "morning")
    :ok = Database.delete(:troy)

    assert Database.get(:troy) == nil
  end

  # TODO @grp wiliam how tes this since it's... random'ish?
  # test "Impl- choose_worker" do
  #   Database.Impl.choose_worker
  # end
end

# TODO next Finish the bk thing of using 3 worker pids instead of just 1. Should be easy
#   Note, Don't think I can add a test. I think just "refactor" and everything still works should be fine
# TODO next ok, I might go back to GenServer's in 1 file. Keep the impl in seperate file and call it State instead of impl
