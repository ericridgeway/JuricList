defmodule Pre8RestartTest.TodoList do
  use ExUnit.Case
  import ShorterMaps

  alias Pre8Restart.{TodoList}

  setup do
    {:ok, pid} = TodoList.start()

    :ok = TodoList.add_entry(pid, %{date: ~D[2018-01-01], title: "Dinner"})
    :ok = TodoList.add_entry(pid, %{date: ~D[2018-01-02], title: "Dentist"})
    :ok = TodoList.add_entry(pid, %{date: ~D[2018-01-02], title: "Meeting"})

    ~M{pid}
  end

  test "new, add_entry, and titles", ~M{pid} do
    assert TodoList.titles(pid, ~D[3000-01-01]) == []
    assert TodoList.titles(pid, ~D[2018-01-02]) == ["Dentist", "Meeting"]
  end

  # test "Can get full entries list, which should include copy of their id", ~M{pid} do
  #   assert %{title: "Dinner", id: 1} =
  #     TodoList.entries(pid, ~D[2018-01-01])
  #     |> hd()
  # end

  # test "update_entry", ~M{pid} do
  #   pid =
  #     pid
  #     |> TodoList.update_entry(1, &Map.put(&1, :date, ~D[1018-01-01]))

  #   assert TodoList.titles(pid, ~D[2018-01-01]) == []
  #   assert TodoList.titles(pid, ~D[1018-01-01]) == ["Dinner"]
  # end

  # test "update_entry validation, new entry should atleast be a map", ~M{pid} do
  #   assert_raise MatchError, fn ->
  #     pid
  #     |> TodoList.update_entry(1, fn _entry -> :notAnEntryMap end)
  #   end
  # end

  # test "update_entry validation, no changing inner id to mismatch", ~M{pid} do
  #   assert_raise MatchError, fn ->
  #     pid
  #     |> TodoList.update_entry(1, &Map.put(&1, :id, :badId))
  #   end
  # end

  # test "update_entry returns unchanged pid if target id doesn't exist", ~M{pid} do
  #   updated_pid =
  #     pid
  #     |> TodoList.update_entry(12345, &Map.put(&1, :date, ~D[1018-01-01]))

  #   assert pid == updated_pid
  # end

  # test "update_entry/2, just give an entry that overwrites an existing one", ~M{pid} do
  #   new_entry =
  #     TodoList.entries(pid, ~D[2018-01-01])
  #     |> hd()
  #     |> Map.put(:date, ~D[1018-01-01])

  #   pid =
  #     pid
  #     |> TodoList.update_entry(new_entry)

  #   assert TodoList.titles(pid, ~D[2018-01-01]) == []
  #   assert TodoList.titles(pid, ~D[1018-01-01]) == ["Dinner"]
  # end

  # test "delete_entry", ~M{pid} do
  #   pid =
  #     pid
  #     |> TodoList.delete_entry(2)

  #   assert TodoList.titles(pid, ~D[2018-01-02]) == ["Meeting"]
  # end
end

# NOTE bk pg 122, iterative new(), and import file. Not gonna bother redo right now
