defmodule StringProcessor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :split_worker,
        start: {SplitWorker, :start_link, []}
      },
      %{
        id: :replace_worker,
        start: {ReplaceWorker, :start_link, []}
      },
      %{
        id: :join_worker,
        start: {JoinWorker, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def process(msg) do
    msg
    |> SplitWorker.split()
    |> ReplaceWorker.replace()
    |> JoinWorker.join()
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end
end

defmodule SplitWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def split(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(arg) do
    {:ok, arg}
  end

  def handle_call(msg, _from, state) do
    {:reply, String.split(msg), state}
  end
end

defmodule ReplaceWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def replace(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    msg = Enum.map(msg, fn word ->
      string = String.downcase(word)
      String.replace(string, ~r/m|n/, fn
        "m" -> "n"
        "n" -> "m"
        _ -> nil
      end)
    end)

    {:reply, msg , state}
  end
end

defmodule JoinWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, Enum.join(msg, " "), state}
  end
end
