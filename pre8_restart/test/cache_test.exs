defmodule Pre8RestartTest.Cache do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{Cache}

  setup do
    cache =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Bob's list")
      |> Cache.put_if_doesnt_exist("Alice's list")

    ~M{cache}
  end

  test "Cache stores unique todoLists under names", ~M{cache} do
    bob = Cache.get(cache, "Bob's list")
    alice = Cache.get(cache, "Alice's list")

    assert bob != alice
  end

  test "put_if_doesnt_exist doesn't overwrite already existing", ~M{cache} do
    bob = Cache.get(cache, "Bob's list")

    cache =
      cache
      |> Cache.put_if_doesnt_exist("Bob's list")

    bob_again = Cache.get(cache, "Bob's list")

    assert bob == bob_again
  end
end
