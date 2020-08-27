defmodule Pre8RestartTest.TodoListPersist do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{Cache, TodoList, Database}

  setup do
    cache =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Doggie", true)

    todo_list =
      Cache.get(cache, "Doggie")
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

    # TODO next where do I put the database.clear? Lots of other tests that have nothing to do with this run basic todoList calls. They're gonna leave db's scattered and might have wierd side effects
    # some kind of default-to-off pass-in-optional-database-module to "activate" persistance I'm thinking (William rec)
    #   and then I know to database.clear only in tests that started it with that optional Database module param

    todo_list =
      Cache.new()
      |> Cache.put_if_doesnt_exist("Doggie", true)
      |> Cache.get("Doggie")

    assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Dentist", "Meeting"]
  end

  # test "Cleanup between
end
