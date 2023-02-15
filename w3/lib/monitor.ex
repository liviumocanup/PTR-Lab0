defmodule MonitoringActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      {:monitoring, pid} ->
        IO.puts("Monitoring...")
        Process.monitor(pid)
        loop()
      {:DOWN, _ref, :process, _obj, reason} ->
        IO.puts("The monitored actor stopped, due to #{reason}.")
    end
  end
end

defmodule MonitoredActor do
  def start do
    spawn(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      {:stop} ->
        IO.puts("Monitored actor received stop message")
        exit(:normal)
    end
    loop()
  end
end
