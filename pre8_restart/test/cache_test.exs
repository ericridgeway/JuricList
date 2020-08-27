defmodule Pre8RestartTest.Cache do
  use ExUnit.Case

  alias Pre8Restart.{Cache}

  test "Cache stores unique todoLists under names" do
    cache =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Bob's list")
      |> Cache.put_if_doesnt_exist("Alice's list")

    bob = Cache.get(cache, "Bob's list")
    alice = Cache.get(cache, "Alice's list")

    assert bob != alice

    cache =
      cache
      |> Cache.put_if_doesnt_exist("Bob's list")

    bob_again = Cache.get(cache, "Bob's list")

    assert bob == bob_again
  end
end
