defmodule ModifyActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      message when is_integer(message) ->
        IO.puts("Received: #{message+1}")

      message when is_bitstring(message) ->
        IO.puts("Received: #{String.downcase(message)}")

      _ ->
        IO.puts("I don't know how to HANDLE this!")
    end

    loop()
  end
end
