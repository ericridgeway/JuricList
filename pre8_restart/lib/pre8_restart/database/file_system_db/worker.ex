defmodule Pre8Restart.Database.FileSystemDb.Worker do
  @db_folder "./persist"

  def new() do
    File.mkdir_p!(@db_folder)

    :ok
  end

  def store(_state, key, value) do
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(value))

    :ok
  end

  def get(_state, key) do
    case File.read(file_name(key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
  end

  def clear(_state) do
    File.rm_rf!(@db_folder)

    :ok
  end


  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
