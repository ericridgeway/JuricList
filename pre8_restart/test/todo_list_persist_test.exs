defmodule Pre8RestartTest.TodoListPersist do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{Cache, TodoList, Database}

  setup do
    todo_list =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Doggie", Database)
      |> Cache.get("Doggie")
      |> TodoList.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})

    on_exit fn ->
      Database.clear()
    end

    ~M{todo_list}
  end

  test "Save between restarts", ~M{todo_list} do
    assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Dentist", "Meeting"]

    # NOTE might need to stop cache here, not todo_list, if cache ever gets turned into a server instead of pure code like I left it for now
    # GenServer.stop(todo_list)

    todo_list =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Doggie", Database)
      |> Cache.get("Doggie")

    assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Dentist", "Meeting"]
  end
end

# TODO switch to Module instead of true for callback practice
