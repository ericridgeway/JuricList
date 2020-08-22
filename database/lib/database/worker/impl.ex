defmodule Database.Worker.Impl do

  @db_folder "./persist"

  # TODO @grp Wait, he's not using state. What's the point of GenServer'ing it then???
  def new() do
    File.mkdir_p!(@db_folder)

    :ok
  end

  def store(_state, key, data) do
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(data))

    # IO.inspect "#{inspect self()}: storing #{key}"

    :ok
  end

  def get(_state, key) do
    case File.read(file_name(key)) do
      {:ok, contents} ->
        :erlang.binary_to_term(contents)

      _ -> nil
    end
  end

  def delete(_state, key) do
    key
    |> file_name()
    |> File.rm()

    :ok
  end


  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
