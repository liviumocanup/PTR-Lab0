defmodule CarSensorSystem do
  use Supervisor

  def start_link(num_wheels) do
    Supervisor.start_link(__MODULE__, num_wheels: num_wheels, name: __MODULE__)
    |> elem(1)
  end

  def init(args) do
    children1 = Enum.map(1..args[:num_wheels], fn i ->
      %{
        id: i,
        start: {WheelSensor, :start_link, []}
      }
    end)

    children2 = [
      %{
        id: :motor_sensor,
        start: {MotorSensor, :start_link, []}
      },
      %{
        id: :cabin_sensor,
        start: {CabinSensor, :start_link, []}
      },
      %{
        id: :chassis_sensor,
        start: {ChassisSensor, :start_link, []}
      },
      %{
        id: :airbag,
        start: {Airbag, :start_link, []}
      }
    ]

    children = children1 ++ children2

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_wheel_pid(pid, id) do
    Supervisor.which_children(pid)
    |> Enum.find(fn {i, _, _, _} -> i == id end)
    |> elem(1)
  end

  def restart(pid, id) do
    Supervisor.restart_child(pid, id)
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end

  def health(pid, count) do
    IO.inspect("Crashes: #{count}")
    Process.sleep(1000)

    if count > 2 do
      IO.inspect("Airbag deployed!")
      :ok
    else
      id = Supervisor.which_children(pid) |> Enum.random() |> elem(1)
      IO.puts("Process crashed:")
      IO.inspect(id)
      Process.exit(id, :kill)
      count = count + 1
      health(pid, count)
    end
  end

  def kill(pid, id) do
    Supervisor.terminate_child(pid, id)
  end
end

defmodule WheelSensor do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def crash(_) do
    handle_info(:crash, %{})
  end

  def handle_info(:crash, _) do
    Logger.warn("Wheel sensor crashed! Restarting...")
    {:restart, :temporary, %{}}
  end
end

defmodule MotorSensor do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def crash(_) do
    handle_info(:crash, %{})
  end

  def handle_info(:crash, state) do
    Logger.warn("Motor sensor crashed! Restarting...")
    {:restart, :temporary, state}
  end
end

defmodule CabinSensor do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def crash(_) do
    handle_info(:crash, %{})
  end

  def handle_info(:crash, state) do
    Logger.warn("Cabin sensor crashed! Restarting...")
    {:restart, :temporary, state}
  end
end

defmodule ChassisSensor do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def crash(_) do
    handle_info(:crash, %{})
  end

  def handle_info(:crash, state) do
    Logger.warn("Chassis sensor crashed! Restarting...")
    {:restart, :temporary, state}
  end
end

defmodule Airbag do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info(:deploy, _) do
    {:noreply, %{}}
  end
end
