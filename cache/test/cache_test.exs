defmodule CacheTest do
  use ExUnit.Case

  test "start() and server_process(..)" do
    {:ok, cache} = Cache.start()

    bob_pid = Cache.server_process(cache, "bob")
    alice_pid = Cache.server_process(cache, "alice")

    # bob_pid_again = Cache.server_process(cache, "bob")

    cache
    |> :sys.get_state()
    |> IO.inspect(label: "cache state")

    assert bob_pid != alice_pid
    # assert bob_pid == bob_pid_again
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
