defmodule Pre8RestartTest.FileSystemDb do
  use ExUnit.Case

  alias Pre8Restart.Database.{FileSystemDb}

  setup do
    FileSystemDb.start()

    on_exit fn ->
      FileSystemDb.clear()
    end

    :ok
  end

  test "FileSystemDb store and get" do
    :ok = FileSystemDb.store(:cat, :meow)
    :ok = FileSystemDb.store(:cat, "doggy")
    :ok = FileSystemDb.store("asd123", "abed is batman")

    assert FileSystemDb.get(:cat) == "doggy"
    assert FileSystemDb.get("asd123") == "abed is batman"
  end

  test "FileSystemDb is clean between tests" do
    assert FileSystemDb.get(:cat) == nil
  end
end
