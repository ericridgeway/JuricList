defmodule JuricListTest.TodoServer do
  use ExUnit.Case

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

    on_exit fn ->
      TodoServer.finish()
    end

    :ok
  end

  test "check add_entry was successful" do
    assert entries(@date1) == ["Dentist", "Movies"]
  end

  test "update_entry" do
    TodoServer.update_entry(2, &Map.put(&1, :date, @date_updated))

    assert entries(@date_updated) == ["Shopping"]
  end

  test "delete_entry" do
    TodoServer.delete_entry(2)

    assert entries(@date2) == []
  end


  defp entries(date) do
    TodoServer.entries(date)
    |> Enum.map(&Map.get(&1, :title))
  end
end
