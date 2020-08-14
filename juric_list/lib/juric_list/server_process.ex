defmodule JuricList.ServerProcess do

  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()
      loop(callback_module, initial_state)
    end)
  end

  def call(pid, request) do
    send(pid, {request, self()})

    receive do
      {:response, response} ->
        response

    # after
    #   5000 -> {:error, :timeout}
    end
  end


  defp loop(callback_module, state) do
    receive do
      {request, caller} ->
        {response, new_state} =
          callback_module.handle_call(request, state)

        send(caller, {:response, response})

        loop(callback_module, new_state)

      _ ->
        # TODO DRY and double check
        IO.puts "incorrect response format"

        loop(callback_module, state)
    end
  end
end
