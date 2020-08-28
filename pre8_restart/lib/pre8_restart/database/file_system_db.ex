defmodule Pre8Restart.Database.FileSystemDb do
  alias Pre8Restart.{Database}

  @behaviour Database

  @db_folder "./persist"

  @impl Database
  def start() do
    File.mkdir_p!(@db_folder)

    :ok
  end

  @impl Database
  def store(key, value) do
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(value))

    :ok
  end

  @impl Database
  def get(key) do
    case File.read(file_name(key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
  end

  @spec clear() :: :ok
  def clear() do
    File.rm_rf!(@db_folder)

    :ok
  end


  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
