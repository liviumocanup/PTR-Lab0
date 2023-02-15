defmodule Semaphore do
  def create_semaphore(count \\ 1) do
    spawn(Semaphore, :loop, [count, count])
  end

  def acquire(pid) do
    ref = make_ref()
    send(pid, {:acquire, self(), ref})
    receive do
      {:ok, ^ref} -> :ok
      {:error, ^ref} -> :error
    end
  end

  def release(pid) do
    send(pid, :release)
    :ok
  end

  def loop(count, max) do
    receive do
      {:acquire, sender, ref} ->
        case count do
          0 ->
            send(sender, {:error, ref})
            loop(count, max)

          count ->
            count = count - 1
            send(sender, {:ok, ref})
            loop(count, max)
        end

      :release ->
        case count do
          _count when count >= max ->
            loop(count, max)

          _count when count < max ->
            count = count + 1
            loop(count, max)
        end
    end
  end
end
