defmodule JuricListTest.TodoList do
  use ExUnit.Case
  import ShorterMaps

  alias JuricList.{TodoList}

  setup do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-12-20], title: "Shopping"})
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Movies"})

    {:ok, ~M{todo_list}}
  end

  test "new, add_entry, and titles", ~M{todo_list} do
    assert TodoList.titles(todo_list, ~D[2018-12-20]) == ["Shopping"]
    assert TodoList.titles(todo_list, ~D[2018-12-19]) == ["Dentist", "Movies"]
    assert TodoList.titles(todo_list, ~D[2018-01-01]) == []
  end

  test "update_entry", ~M{todo_list} do
    todo_list =
      todo_list
      |> TodoList.update_entry(2, &Map.put(&1, :date, ~D[2020-01-01]))

    assert TodoList.titles(todo_list, ~D[2018-12-20]) == []
    assert TodoList.titles(todo_list, ~D[2020-01-01]) == ["Shopping"]
  end
end
