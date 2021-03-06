defmodule JuricListTest.KeyValueStore do
  use ExUnit.Case

  alias JuricList.{KeyValueStore}

  test "KeyValueStore (using custom generic Server process without us seeing)" do
    {:ok, pid} = KeyValueStore.start()

    :ok = KeyValueStore.put(pid, :some_key, :some_value)
    reply = KeyValueStore.get(pid, :some_key)

    assert reply == :some_value
  end
end
