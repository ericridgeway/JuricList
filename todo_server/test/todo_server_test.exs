defmodule TodoServerTest do
  use ExUnit.Case
  import ShorterMaps

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]
  @date_updated ~D[2020-01-01]

  setup do
    :ok = Database.delete("robin")
    # TODO next ok problem is here. For some reason it's not being deleted here
    Process.sleep(500)
    # assert Database.get("robin") == nil
    # Oh motherf'r. I bet it's because of cast and not call I'm not getting error msg. I knew that was sketchy
    # And I'm thinking the problem is Database isn't Start'd at this point, lets test
    IO.puts "111111"; require InspectVars; InspectVars.inspect([])
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
    {:ok, todo_server} = TodoServer.start("batman")

    assert TodoServer.name(todo_server) == "batman"
  end

  test "Saves state thru server restart/crash", ~M{todo_server} do
    assert entries(todo_server, @date1) == ["Dentist", "Movies"]

    IO.puts "222"; require InspectVars; InspectVars.inspect([])
    # restart server
    {:ok, new_todo_server} = TodoServer.start("robin")
    assert entries(new_todo_server, @date1) == ["Dentist", "Movies"]

    # TODO ok, add the database-read check (re next section of book)
    # TODO after that, do all the other possible commands, delete_entry etc,
    # and confirm they're all updateing the database too
    #   TODO NOTE, that seems duplicate'y. Maybe I can find a way that they all
    #   do it automatically. Look at TodoServer.Impl and decide after in a refactor prob
  end

  defp entries(todo_server, date) do
    TodoServer.entries(todo_server, date)
    |> Enum.map(&Map.get(&1, :title))
  end
end
