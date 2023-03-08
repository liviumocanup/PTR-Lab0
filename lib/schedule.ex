defmodule Schedule do
  def create_scheduler do
    spawn(fn -> init() end)
  end

  defp init do
    Process.flag(:trap_exit, true)
    loop()
  end

  def schedule(pid, task) do
    send(pid, {:schedule, task})
  end

  defp new_worker(task) do
    spawn_link(fn -> attempt_task(task) end)
  end

  defp attempt_task(task) do
    if :rand.uniform(10) < 5 do
      exit(:normal)
    else
      exit(task)
    end
  end

  defp loop do

    receive do
      {:schedule, task} ->
        new_worker(task)

      {:EXIT, _pid, :normal} ->
        IO.puts("Task succesful: Miau")

      {:EXIT, _pid, task} ->
        IO.puts("Task fail")
        new_worker(task)
    end
    loop()
  end
end
