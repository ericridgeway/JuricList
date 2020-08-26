defmodule Pre8RestartTest.TodoServer do
  use ExUnit.Case

  alias Pre8Restart.{TodoServer}

  @date1 ~D[2018-01-01]

  test "Wrap todolist in genserver" do
    {:ok, pid} = TodoServer.start()

    :ok = TodoServer.add_entry(pid, %{date: @date1, title: "Sing"})

    assert TodoServer.titles(pid, @date1) == ["Sing"]
  end
end
