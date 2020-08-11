defmodule JuricListTest.TodoList do
  use ExUnit.Case

  alias JuricList.{TodoList}

  test "new, add_entry, and titles" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-12-20], title: "Shopping"})
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Movies"})

    IO.puts ""; require InspectVars; InspectVars.inspect([todo_list])
    assert TodoList.titles(todo_list, ~D[2018-12-20]) == ["Shopping"]
    assert TodoList.titles(todo_list, ~D[2018-12-19]) == ["Dentist", "Movies"]
    assert TodoList.titles(todo_list, ~D[2018-01-01]) == []
  end
end
