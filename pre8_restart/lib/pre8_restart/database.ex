defmodule Pre8Restart.Database do
  alias Pre8Restart.{DatabaseDef}

  @behaviour DatabaseDef

  @db_folder "./persist"

  @impl DatabaseDef
  def start() do
    File.mkdir_p!(@db_folder)

    :ok
  end

  @impl DatabaseDef
  def store(key, value) do
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(value))

    :ok
  end

  @impl DatabaseDef
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
