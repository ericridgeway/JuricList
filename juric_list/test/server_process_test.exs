defmodule JuricListTest.ServerProcess do
  use ExUnit.Case

  alias JuricList.{ServerProcess, KeyValueStore}

  test "Extract generic Server process" do
    pid = KeyValueStore.start()

    :ok = KeyValueStore.put(pid, :some_key, :some_value)
    reply = KeyValueStore.get(pid, :some_key)

    assert reply == :some_value
  end
end
