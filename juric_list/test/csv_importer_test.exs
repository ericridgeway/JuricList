defmodule JuricListTest.CsvImporter do
  use ExUnit.Case

  alias JuricList.{CsvImporter}

  test "import" do
    todo_list = CsvImporter.import("#{__DIR__}/todos.csv")

    assert TodoList.titles(todo_list, ~D[2018-12-19]) == ["Dentist", "Movies"]
    assert TodoList.titles(todo_list, ~D[2018-12-20]
) == ["Shopping"]
    assert TodoList.titles(todo_list, ~D[1500-01-01]) == []
  end
end
