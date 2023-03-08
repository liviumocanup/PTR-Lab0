defmodule PrintActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      message ->
        IO.puts("Received: #{message}")
        loop()
    end
  end
end
