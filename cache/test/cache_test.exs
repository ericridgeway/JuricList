defmodule CacheTest do
  use ExUnit.Case

  setup do
    Cache.start_link()

    :ok
  end

  test "start() and server_process(..)" do
    bob_pid = Cache.server_process("bob")
    alice_pid = Cache.server_process("alice")

    assert bob_pid != alice_pid
  end

  test "Asking for same name gets original pid, doesn't delete and make new" do
    bob_pid = Cache.server_process("bob")
    bob_pid_again = Cache.server_process("bob")

    assert bob_pid == bob_pid_again
  end


  test "Confirm we're getting real todoservers" do
    bob_pid = Cache.server_process("bob")
    entry = %{date: ~D[2018-12-19], title: "Dentist"}

    :ok = TodoServer.add_entry(bob_pid, entry)

    reply_entry =
      TodoServer.entries(bob_pid, entry.date)
      |> hd()

    assert reply_entry.title == "Dentist"
  end

  test "Cache passes name to todoserver when creating it" do
    bob_pid = Cache.server_process("bob")

    assert TodoServer.name(bob_pid) == "bob"
  end
end
