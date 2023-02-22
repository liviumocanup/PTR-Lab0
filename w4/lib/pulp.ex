defmodule Pulp do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :samuel,
        start: {Samuel, :start_link, []}
      },
      %{
        id: :dude,
        start: {Dude, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def loop() do
    Samuel.ask()
    loop()
  end

  def count() do
    Supervisor.count_children(__MODULE__)
  end
end

defmodule Samuel do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ask() do
    GenServer.call(__MODULE__, :ask)
  end

  def init(_) do
    state = %{
      count: 0
    }
    {:ok, state}
  end

  def handle_call(:ask, _, state) do
    Process.sleep(1500)

    IO.puts("Samuel Jackson: Where is the money Lebowski?")

    answer = Dude.answer()

    if (answer == "What?") do
      state = %{state | count: state[:count] + 1}

      case state[:count] do
        3 ->
          Process.sleep(500)
          IO.puts("*Brains fly everywhere*")
          Dude.kill()
        2 ->
          Process.sleep(500)
          IO.puts("Samuel Jackson: I double dare you to say what one more time.")
        _ -> :ok
      end

      {:reply, %{}, state}
    else
      {:reply, %{}, state}
    end
  end
end

defmodule Dude do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def answer() do
    GenServer.call(__MODULE__, :answer)
  end

  def kill() do
    GenServer.cast(__MODULE__, :kill)
  end

  def init(args) do
    {:ok, args}
  end

  def handle_call(:answer, _, _) do
    Process.sleep(2000)

    if (:rand.uniform() > 0.3) do
      IO.puts("Lebowski: I think it's down there let me have another look.")
      {:reply, "Ok", %{}}
    else
      IO.puts("Lebowski: What?")
      {:reply, "What?", %{}}
    end
  end

  def handle_cast(:kill, _) do
    {:stop, :normal, %{}}
  end
end
