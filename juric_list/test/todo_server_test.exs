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

  test "TODO", ~M{todo_server} do
    :ok = TodoServer.add_entry(todo_server, %{date: @date1, title: "Dentist"})
    :ok = TodoServer.add_entry(todo_server, %{date: @date2, title: "Shopping"})
    :ok = TodoServer.add_entry(todo_server, %{date: @date1, title: "Movies"})

    # assert TodoServer.titles(todo_server, @date1) == ["Dentist", "Movies"]
  end
end
