defmodule Queue do
  def new_queue do
    spawn(Queue, :loop, [[]])
  end

  def push(pid, value) do
    send(pid, {:push, value})
    :ok
  end

  def pop(pid) do
    send(pid, {:pop, self()})
    receive do
      value -> value
    end
  end

  def loop(queue) do
    receive do
      {:push, value} ->
        loop(queue ++ [value])

      {:pop, sender} ->
        case queue do
          [] ->
            send(sender, :empty)
            loop(queue)

          [head | tail] ->
            send(sender, head)
            loop(tail)
        end
    end
  end
end
