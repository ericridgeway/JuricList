defmodule Pre8RestartTest.TodoList do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{TodoList}

  setup do
    TodoList.initialize()

    todo_list =
      TodoList.create()
      |> TodoList.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})
      |> IO.inspect(label: "")

    ~M{todo_list}
  end

  test "new, add_entry, and titles", ~M{todo_list} do
    assert TodoList.titles(todo_list, ~D[3000-01-01]) == []
    assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Dentist", "Meeting"]
  end

  # test "Can get full entries list, which should include copy of their id", ~M{todo_list} do
  #   assert %{title: "Dinner", id: 1} =
  #     TodoList.entries(todo_list, ~D[2018-01-01])
  #     |> hd()
  # end

  # test "update_entry", ~M{todo_list} do
  #   todo_list =
  #     todo_list
  #     |> TodoList.update_entry(1, &Map.put(&1, :date, ~D[1018-01-01]))

  #   assert TodoList.titles(todo_list, ~D[2018-01-01]) == []
  #   assert TodoList.titles(todo_list, ~D[1018-01-01]) == ["Dinner"]
  # end

  # test "update_entry validation, new entry should atleast be a map", ~M{todo_list} do
  #   assert_raise MatchError, fn ->
  #     todo_list
  #     |> TodoList.update_entry(1, fn _entry -> :notAnEntryMap end)
  #   end
  # end

  # test "update_entry validation, no changing inner id to mismatch", ~M{todo_list} do
  #   assert_raise MatchError, fn ->
  #     todo_list
  #     |> TodoList.update_entry(1, &Map.put(&1, :id, :badId))
  #   end
  # end

  # test "update_entry returns unchanged todo_list if target id doesn't exist", ~M{todo_list} do
  #   updated_todo_list =
  #     todo_list
  #     |> TodoList.update_entry(12345, &Map.put(&1, :date, ~D[1018-01-01]))

  #   assert todo_list == updated_todo_list
  # end

  # test "update_entry/2, just give an entry that overwrites an existing one", ~M{todo_list} do
  #   new_entry =
  #     TodoList.entries(todo_list, ~D[2018-01-01])
  #     |> hd()
  #     |> Map.put(:date, ~D[1018-01-01])

  #   todo_list =
  #     todo_list
  #     |> TodoList.update_entry(new_entry)

  #   assert TodoList.titles(todo_list, ~D[2018-01-01]) == []
  #   assert TodoList.titles(todo_list, ~D[1018-01-01]) == ["Dinner"]
  # end

  # test "delete_entry", ~M{todo_list} do
  #   todo_list =
  #     todo_list
  #     |> TodoList.delete_entry(2)

  #   assert TodoList.titles(todo_list, ~D[2018-01-02]) == ["Meeting"]
  # end
end

# NOTE bk pg 122, iterative new(), and import file. Not gonna bother redo right now
