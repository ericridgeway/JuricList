defmodule TodoServerTest do
  use ExUnit.Case
  import ShorterMaps

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]
  @date_updated ~D[2020-01-01]

  setup do
    Database.start()

    :ok = Database.delete("robin")
    :ok = Database.delete("robin")

    {:ok, todo_server} = TodoServer.start("robin")

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

  test "TodoServer knows its own name" do
    :ok = Database.delete("batman")
    {:ok, todo_server} = TodoServer.start("batman")

    assert TodoServer.name(todo_server) == "batman"
  end

  # TODO dif test file for database tests, or something. It's doubling all the add_entry delete_entry, edit_entry etc...

  test "Saves state thru server restart/crash", ~M{todo_server} do
    assert entries(todo_server, @date1) == ["Dentist", "Movies"]

    todo_server = restart_server("robin")

    assert entries(todo_server, @date1) == ["Dentist", "Movies"]
  end

  test "Server crash, also saved: update", ~M{todo_server} do
    assert entries(todo_server, @date_updated) == []
    :ok = TodoServer.update_entry(todo_server, 2, &Map.put(&1, :date, @date_updated))
    assert entries(todo_server, @date_updated) == ["Shopping"]

    todo_server = restart_server("robin")

    assert entries(todo_server, @date_updated) == ["Shopping"]
  end

  defp entries(todo_server, date) do
    TodoServer.entries(todo_server, date)
    |> Enum.map(&Map.get(&1, :title))
  end

  defp restart_server(name) do
    {:ok, todo_server} = TodoServer.start(name)

    todo_server
  end
end

  # @tag :skip
