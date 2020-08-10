defmodule JuricListTest.TodoList do
  use ExUnit.Case

  alias JuricList.{TodoList}

  test "new, add_entry, and entries" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(~D[2018-12-19], "Dentist")
      |> TodoList.add_entry(~D[2018-12-20], "Shopping")
      |> TodoList.add_entry(~D[2018-12-19], "Movies")

    assert TodoList.entries(todo_list, ~D[2018-12-20]) == ["Shopping"]
    assert TodoList.entries(todo_list, ~D[2018-12-19]) == ["Dentist", "Movies"]
  end
end
