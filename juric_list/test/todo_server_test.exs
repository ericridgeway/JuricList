defmodule JuricListTest.TodoServer do
  use ExUnit.Case, async: false

  import ShorterMaps

  alias JuricList.{TodoServer}

  @date1 ~D[2018-12-19]
  @date2 ~D[2018-12-20]
  @date_updated ~D[2020-01-01]

  setup do
    _todo_server = TodoServer.start()
   Process.sleep(200)
    TodoServer.add_entry(%{date: @date1, title: "Dentist"})
    TodoServer.add_entry(%{date: @date2, title: "Shopping"})
    TodoServer.add_entry(%{date: @date1, title: "Movies"})

    # TODO next ok, I need the kill registered process teardown afterall...

    # TODO notes to class, the bs Process.sleep hack he used, that it's the solution to that vague error, and also WHY is it needed. Some kind of async Process.register slowness thing where program doesn't pause and wait for Process.register before going along it's merry way?
    #
    # 2- This teardown needed for multiple tests not fighting, test2's setup trys to register name, but test1 already dibs'd it

    # ~M{todo_server}
    :ok
  end

  test "check add_entry was successful" do
    assert entries(@date1) == ["Dentist", "Movies"]
  end

  test "update_entry" do
    TodoServer.update_entry(2, &Map.put(&1, :date, @date_updated))

    assert entries(@date_updated) == ["Shopping"]
  end

  # test "delete_entry", ~M{todo_server} do
  #   TodoServer.delete_entry(2)

  #   assert entries(@date2) == []
  # end


  defp entries(date) do
    TodoServer.entries(date)
    |> Enum.map(&Map.get(&1, :title))
  end
end
