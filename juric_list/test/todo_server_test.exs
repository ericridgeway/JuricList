defmodule JuricListTest.TodoServer do
  use ExUnit.Case
  import ShorterMaps

  alias JuricList.{TodoServer}

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]

  setup do
    todo_server = TodoServer.start()

    on_exit fn ->
      TodoServer.finish(todo_server)
    end

    ~M{todo_server}
  end

  test "add_entry", ~M{todo_server} do
    TodoServer.add_entry(todo_server, %{date: @date1, title: "Dentist"})
    TodoServer.add_entry(todo_server, %{date: @date2, title: "Shopping"})
    TodoServer.add_entry(todo_server, %{date: @date1, title: "Movies"})

    entries =
      TodoServer.entries(todo_server, @date1)
      |> Enum.map(&Map.get(&1, :title))

    assert entries == ["Dentist", "Movies"]
  end
end
