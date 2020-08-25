defmodule Pre8RestartTest.TodoList do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{TodoList}

  setup do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})

    ~M{todo_list}
  end

  test "new, add_entry, and titles", ~M{todo_list} do
    assert TodoList.titles(todo_list, ~D[3000-01-01]) == []
    assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Dentist", "Meeting"]
  end

  test "Can get full entries list, which should include copy of their id", ~M{todo_list} do
    assert %{title: "Dinner", id: 1} =
      TodoList.entries(todo_list, ~D[2018-01-01])
      |> hd()
  end
end
