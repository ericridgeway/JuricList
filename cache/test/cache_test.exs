defmodule CacheTest do
  use ExUnit.Case
  import ShorterMaps

  setup do
    {:ok, cache} = Cache.start()
    # {:ok, cache} = start_supervised(Cache)

    ~M{cache}
  end

  test "start() and server_process(..)", ~M{cache} do
    bob_pid = Cache.server_process(cache, "bob")
    alice_pid = Cache.server_process(cache, "alice")

    assert bob_pid != alice_pid
  end

  test "Asking for same name gets original pid, doesn't delete and make new", ~M{cache} do
    bob_pid = Cache.server_process(cache, "bob")
    bob_pid_again = Cache.server_process(cache, "bob")

    assert bob_pid == bob_pid_again
  end


  test "Confirm we're getting real todoservers", ~M{cache} do
    bob_pid = Cache.server_process(cache, "bob")
    entry = %{date: ~D[2018-12-19], title: "Dentist"}

    :ok = TodoServer.add_entry(bob_pid, entry)

    reply_entry =
      TodoServer.entries(bob_pid, entry.date)
      |> hd()

    assert reply_entry.title == "Dentist"
  end

  test "Cache passes name to todoserver when creating it", ~M{cache} do
    bob_pid = Cache.server_process(cache, "bob")

    assert TodoServer.name(bob_pid) == "bob"
  end

  # test "Saves state thru server restart/crash", ~M{todo_server} do
  #   assert entries(todo_server, @date1) == ["Dentist", "Movies"]

  #   # restart server
  #   {:ok, new_todo_server} = TodoServer.start("robin")
  #   assert entries(new_todo_server, @date1) == ["Dentist", "Movies"]
  # end
end

    # cache
    # |> :sys.get_state()
    # |> IO.inspect(label: "cache state")

