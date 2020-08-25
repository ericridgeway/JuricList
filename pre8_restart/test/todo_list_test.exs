defmodule Pre8RestartTest.TodoList do
  use ExUnit.Case

  alias Pre8Restart.{TodoList}

  test "new, add_entry, and titles" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})

    assert TodoList.titles(todo_list, ~D[3000-01-01]) == []
    # assert TodoList.titles(~D[2018-01-02]) == ["Dentist", "Meeting"]
  end
end
