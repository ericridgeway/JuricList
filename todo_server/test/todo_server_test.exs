defmodule TodoServerTest do
  use ExUnit.Case
  import ShorterMaps

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]
  @date_updated ~D[2020-01-01]

  setup do
    {:ok, todo_server} = TodoServer.start()

    :ok = TodoServer.add_entry(todo_server, %{date: @date1, title: "Dentist"})
    :ok = TodoServer.add_entry(todo_server, %{date: @date2, title: "Shopping"})
    :ok = TodoServer.add_entry(todo_server, %{date: @date1, title: "Movies"})

    ~M{todo_server}
  end

  test "check add_entry was successful", ~M{todo_server} do
    assert entries(todo_server, @date1) == ["Dentist", "Movies"]
  end

  test "update_entry", ~M{todo_server} do
    :ok = TodoServer.update_entry(todo_server, 2, &Map.put(&1, :date, @date_updated))

    assert entries(todo_server, @date_updated) == ["Shopping"]
  end

  test "delete_entry", ~M{todo_server} do
    :ok = TodoServer.delete_entry(todo_server, 2)

    assert entries(todo_server, @date2) == []
  end


  defp entries(todo_server, date) do
    TodoServer.entries(todo_server, date)
    |> Enum.map(&Map.get(&1, :title))
  end
end
