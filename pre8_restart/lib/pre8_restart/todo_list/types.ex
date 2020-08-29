defmodule Pre8Restart.TodoList.Types do

  defmacro get_shared() do
    quote do
      @type entry :: %{id: id, date: date, title: title}

      @type id :: pos_integer
      @type date :: Date.t
      @type title :: String.t

      @type name :: String.t
      @type database :: module
    end
  end
end

# ASK a- The import/get_shared looks funny. Maybe I can live with it. Would be nice if we could just import types
# b- I'm still duplicating the types and methods themselves in state and top lvl
