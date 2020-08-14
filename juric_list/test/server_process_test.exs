defmodule JuricListTest.ServerProcess do
  use ExUnit.Case

  alias JuricList.{ServerProcess, KeyValueStore}

  test "Extract generic Server process" do
    pid = ServerProcess.start(KeyValueStore)

    :ok = ServerProcess.call(pid, {:put, :some_key, :some_value})
    reply = ServerProcess.call(pid, {:get, :some_key})

    assert reply == :some_value
  end
end
