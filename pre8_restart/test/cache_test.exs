defmodule Pre8RestartTest.Cache do
  use ExUnit.Case

  alias Pre8Restart.{Cache}

  test "Cache stores unique todoLists under names" do
    cache =
      Cache.new()

    bob = Cache.fetch_list(cache, "Bob's list")
    bob_again = Cache.fetch_list(cache, "Bob's list")
    alice = Cache.fetch_list(cache, "Alice's list")

    assert bob != alice
    # assert bob == bob_again
  end
end
