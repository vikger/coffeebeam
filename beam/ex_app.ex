defmodule ExApp do
  defmodule State do
    defstruct id: 0, name: nil
  end

  def start do
    :ok
  end

  def state do
    %State{id: 1, name: "first"}
  end
end
