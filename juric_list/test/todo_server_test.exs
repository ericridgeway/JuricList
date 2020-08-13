defmodule JuricListTest.TodoServer do
  use ExUnit.Case
  import ShorterMaps

  alias JuricList.{TodoServer}

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]

  setup do
    todo_server = TodoServer.start()

    on_exit fn ->
      TodoServer.finish(todo_server)
    end

    ~M{todo_server}
  end

  test "TODO", ~M{todo_server} do
    # TODO @grp The answer might be obvious once you give it, but... I've forgotten why we smetimes
    #   want to do this. add OOP/genserver concept. We don't have to do
    #   todo_list2 = TodoList.do_something(todo_list1, ...)
    #   etc. a bunch of times. But pipelines/the entire point of elixir/functional
    #   goes a long way to minimize that being much (if any) of an annoyance
    #
    #   so what are the situations where we want to use this again? Only when we need
    #   to start thinking about 2+ clients calling it at once or something? And even then,
    #   why couldn't we just hold the passed-back 'new_todo_list' each time or something?

    TodoServer.add_entry(todo_server, %{date: @date1, title: "Dentist"})
    TodoServer.add_entry(todo_server, %{date: @date2, title: "Shopping"})
    TodoServer.add_entry(todo_server, %{date: @date1, title: "Movies"})

    assert TodoServer.titles(todo_server, @date1) == ["Dentist", "Movies"]
  end
end
