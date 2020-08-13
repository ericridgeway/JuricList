defmodule JuricListTest.TodoList do
  use ExUnit.Case
  import ShorterMaps

  alias JuricList.{TodoList}

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]
  @date_updated ~D[2020-01-01]

  setup do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: @date1, title: "Dentist"})
      |> TodoList.add_entry(%{date: @date2, title: "Shopping"})
      |> TodoList.add_entry(%{date: @date1, title: "Movies"})

    {:ok, ~M{todo_list}}
  end

  test "new, add_entry, and titles", ~M{todo_list} do
    assert TodoList.titles(todo_list, @date1) == ["Dentist", "Movies"]
    assert TodoList.titles(todo_list, @date2) == ["Shopping"]
    assert TodoList.titles(todo_list, ~D[1500-01-01]) == []
  end

  test "update_entry", ~M{todo_list} do
    todo_list =
      todo_list
      |> TodoList.update_entry(2, &Map.put(&1, :date, @date_updated))

    assert TodoList.titles(todo_list, @date2) == []
    assert TodoList.titles(todo_list, @date_updated) == ["Shopping"]
  end

  test "update_entry, no error if no matching id (just return unchanged)", ~M{todo_list} do
    new_todo_list =
      todo_list
      |> TodoList.update_entry(:bad_id, &Map.put(&1, :date, @date_updated))

    assert todo_list == new_todo_list
  end

  test "update_entry, validate updater_fun's proposed entry", ~M{todo_list} do
    assert_raise MatchError, fn ->
      todo_list
      |> TodoList.update_entry(1, fn _ -> :bad_entry end)
    end

    assert_raise MatchError, fn ->
      todo_list
      |> TodoList.update_entry(1, &Map.put(&1, :id, :bad_id))
    end
  end

  test "delete_entry", ~M{todo_list} do
    assert TodoList.titles(todo_list, @date2) == ["Shopping"]

    todo_list =
      todo_list
      |> TodoList.delete_entry(2)

    assert TodoList.titles(todo_list, @date2) == []
  end

  test "new/1 with list (of entries)" do
    entries = [
      %{date: @date1, title: "Dentist"},
      %{date: @date2, title: "Shopping"},
      %{date: @date1, title: "Movies"},
    ]

    todo_list = TodoList.new(entries)

    assert TodoList.titles(todo_list, @date1) == ["Dentist", "Movies"]
    assert TodoList.titles(todo_list, @date2) == ["Shopping"]
    assert TodoList.titles(todo_list, ~D[1500-01-01]) == []
  end

  test "entries gets list of entry maps", ~M{todo_list} do
    entries = TodoList.entries(todo_list, @date2)
    [first_entry | _] = entries

    assert first_entry.title == "Shopping"
  end
end
