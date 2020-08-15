defmodule CacheTest do
  use ExUnit.Case
  import ShorterMaps

  setup do
    # {:ok, cache} = start_supervised(Cache)
    {:ok, cache} = Cache.start()

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


  # test "TODO" do
  # TODO start_supervised thing in setup block prob
  #   entry = %{date: ~D[2018-12-19], title: "Dentist"}
  #   :ok = TodoServer.add_entry(bob_pid, entry)

  #   # TODO extract entries |> titles helper function I had in one of the other tests? or just always take entries and pull what you need from them...?
  #   reply_entry =
  #     TodoServer.entries(bob_pid, entry.date)
  #     |> hd()

  #   assert entry == reply_entry
  # end
end

    # cache
    # |> :sys.get_state()
    # |> IO.inspect(label: "cache state")

