# FAF.PTR16.1 -- Project 0
> **Performed by:** Mocanu Liviu, group FAF-203
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W2

**Task 1** -- Determine whether an input integer in prime.

```elixir
  def isPrime(n) do
    if n<2 do
      false
    else
      if Enum.count(2..n, fn x -> rem(n, x) == 0 end)>1 do
        false
      else
        true
      end
    end
  end
```

`is_prime` function checks if n is less than 2 and if so, returns false. Otherwise, it counts how many integers between 2 and n (inclusive) evenly divide into n. If this count is greater than 1, the function returns false because n is not prime. Otherwise, the function returns true because n is prime.

**Task 2** -- Calculate the area of a cylinder

```elixir
  def cylinderArea(h, r) when h>0 and r>0 do
    2 * :math.pi * r * (r + h)
  end

  def cylinderArea(_, _) do
    -1
  end
```

`cylinder_area` function takes the radius `r` and the height `h` of a cylinder and returns the area of the cylinder. In case the radius and height are negative (which shouldn't be possible), the function returns -1 instead.

**Task 3** -- Reverse a List

```elixir
  def reverse(list) do
    Enum.reverse(list)
  end
```

`reverse_list` function takes a list and returns the reversed list.

**Task 4** -- Calculate the sum of unique elements in a list

```elixir
  def uniqueSum(list) do
    Enum.uniq(list) |> Enum.sum()
  end
```

`unique_sum` function takes a list of numbers as input, removes any duplicates in the list, and returns the sum of the remaining unique numbers in the list.

**Task 5** -- Extract a given number of randomly selected elements from a list.

```elixir
  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end
```

`extract_random_list` function takes a list and a number n as input, and returns a new list containing n randomly selected elements from the original list.

**Task 6** --  Return the first n elements of the Fibonacci sequence.
```elixir
  def firstFibonacciElements(n) do
    if n == 1 do
      [1]
    else
      if n == 2 do
        [1, 1]
      else
        previousTerms = firstFibonacciElements(n - 1)
        previousTerms ++ [Enum.at(previousTerms, n - 2) + Enum.at(previousTerms, n - 3)]
      end
    end
  end
```

`first_fibonacci` function takes a number n as input and returns a list of the first n elements of the Fibonacci sequence. The function uses recursion to compute each element in the sequence. If `n` is 1, it returns `[1]`. If `n` is 2, it returns `[1, 1]`. Otherwise, it gets the next Fibonacci number by adding the previous two elements.

**Task 7** -- Translate a sententence given a dictionary

```elixir
  def translator(dictionary, text) do
    words = Enum.map(String.split(text, " "), fn word -> Map.get(dictionary, String.to_atom(word), word) end)
    Enum.join(words, " ")
  end
```

`translate` function takes a dictionary and a text and returns the text translated using the dictionary. It splits the text in separate words by space and after replacing the words found in dictionary, it joins all the words back.

**Task 8** -- Create the smallest number from 3 digits

```elixir
  def smallestNumber(a, b, c) do
    list = Enum.sort([a, b, c])
    zeroes = Enum.count(list, &(&1 == 0))
    if zeroes == 3 do
      0
    else
      if zeroes == 2 do
        rotateLeft(list, 2) |> Enum.join()
      end
      if zeroes == 1 do
        Enum.reverse(rotateLeft(list, 2)) |> Enum.join()
      else
        Enum.join(list)
      end
    end
  end

  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end
```

The first function, `smallestNumber`, takes three numbers as input and returns a string representation of those numbers in ascending order. If all three numbers are 0, the function returns 0 instead. The function achieves this by first sorting the input numbers in ascending order using `Enum.sort`, and then rotating the resulting list to the left by two positions (for inputs with exactly two zeros) or by one position (for inputs with exactly one zero) using the function `rotateLeft` from `Task 9` where it will be explained more in-depth. Finally, the function joins the elements of the resulting list together into a string using `Enum.join`.

**Task 9** -- Rotate a list n places to the left

```elixir
  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end
```

`rotateLeft`, function takes a list and an integer n as input and returns a new list where the first n elements of the original list have been moved to the end of the list. This is accomplished by splitting the original list into two parts using `Enum.split`, and then concatenating those parts in reverse order using the `++` operator.

**Task 10** -- List right angle triangles

```elixir
  def lastRightAngleTriangles do
    Enum.reduce(1..20, [], fn a, acc ->
      Enum.reduce(1..20, acc, fn b, acc ->
        c = :math.sqrt(a*a + b*b)
        if c == :math.floor(c) do
          [{a, b, c} | acc]
        else
          acc
        end
      end)
    end)
    |> Enum.sort
  end
```

`list_right_angle_triangles` function lists all tuples a, b, c such that a<sup>2</sup>
+b<sup>2</sup> = c<sup>2</sup> and a, b ≤ 20

**Task 11** -- Eliminate consecutive duplicates in a list

```elixir
  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end
```

`remove_consecutive_duplicates` function takes a list and returns the list with consecutive duplicates removed.

**Task 12** -- Return the words that can
be typed using only one row of the letters on an English keyboard layout

```elixir
  def lineWords(words) do
    rows = [
      "qwertyuiop",
      "asdfghjkl",
      "zxcvbnm"
    ]
    Enum.filter(words, fn word ->
      Enum.any?(rows, fn row ->
        Enum.all?(String.graphemes(String.downcase(word)), fn letter ->
          String.contains?(row, letter) end) end) end)
  end
```

`one_row_words` function takes a list of words as input and returns a new list containing only those words that can be typed using the characters from a single row of a standard keyboard layout. The function works by defining a list of three strings, each containing the letters from a different row of the keyboard. It then uses the `Enum.filter` function to select only those words from the input list that satisfy the condition of having all their letters contained in a single one of these rows. This is checked by using `Enum.any?` and `Enum.all?` to iterate over the rows and letters of each word.

**Task 13** -- Create a pair of functions to encode and decode strings using the Caesar cipher

```elixir
  def encode(message, shift) do
    String.to_charlist(message)
    |> Enum.map(fn letter -> shiftChar(letter, shift) end)
    |> List.to_string
  end

  defp shiftChar(letter, shift) do
    cond do
      letter in ?a..?z -> rem(letter - ?a + shift, 26) + ?a
      letter in ?A..?Z -> rem(letter - ?A + shift, 26) + ?A
      true -> letter
    end
  end

  def decode(message, shift) do
    encode(message, -shift)
  end
```

`encode` function takes a message string and a shift value as input and returns a new string where each letter in the input message has been shifted forward by shift positions in the alphabet by using the helper function `shiftChar` to shift each letter, and then converts the resulting list of characters back into a string using List.to_string.

`decode` function is the same as `encode` but with a negative shift.

The `shiftChar` function takes a single character and a shift value as input and returns a new character where the input character has been shifted forward in the alphabet by the specified number of positions. The function handles lowercase and uppercase letters separately by converting each letter to its integer code and then performing the shift using modular arithmetic to ensure that the resulting code is always in the appropriate range. Any non-letter characters are returned unchanged.

**Task 14** -- Return all possible letter combinations that the number could represent,  given a string of digits from 2 to 9

```elixir
  @dict %{"2" => ["a","b","c"], "3" => ["d","e","f"], "4" => ["g","h","i"], "5" => ["j","k","l"], "6" => ["m","n","o"], "7" => ["p","q","r"], "8" => ["s","t","u"],"9" => ["v","w","x"]}

  def lettersCombination(""), do: [""]

  def lettersCombination(<<key::binary-1, rest::binary>>) do
    for letter <- @dict[key], tail <- lettersCombination(rest), do: letter <> tail
  end
```

`lettersCombination` function generates all possible combinations of letters that can be formed from a given phone keypad input. It works by using a dictionary `@dict` that maps each digit to the corresponding list of letters, and recursively combining the letters in each digit of the input string to generate all possible combinations. The base case of the recursion is an empty input string, which returns an empty list of combinations.

**Task 15** -- Group anagrams together given an array of strings

```elixir
  def groupAnagrams(words) do
    Enum.group_by(words, fn word -> String.trim(word)
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
    |> List.to_string end)
  end
```

`group_anagrams` function takes a list of words as input and groups them into sub-lists where each sub-list contains all the words that are anagrams of each other. It works by using the `Enum.group_by` function to group the input words based on a key that is generated by transforming each word to lowercase, removing any leading or trailing whitespace, splitting the resulting string into individual graphemes, sorting the graphemes, and then concatenating them back into a single string.

**Task 16** -- Convert arabic numbers to roman numerals

```elixir
  def arabic_to_roman(number) do
    symbols = [
      {:M, 1000},
      {:CM, 900},
      {:D, 500},
      {:CD, 400},
      {:C, 100},
      {:XC, 90},
      {:L, 50},
      {:XL, 40},
      {:X, 10},
      {:IX, 9},
      {:V, 5},
      {:IV, 4},
      {:I, 1}
    ]
    roman_helper(number, symbols, []) |> Enum.join
  end

  def roman_helper(number, symbols, result) do
    case symbols do
      [{symbol, value} | tail] ->
        if number >= value do
          roman_helper(number - value, symbols, result ++ [symbol])
        else
          roman_helper(number, tail, result)
        end
      [] -> result
    end
  end
```

`arabic_to_roman` function takes a positive integer number and converts it to its equivalent Roman numeral representation. It uses a list of tuples that associate Roman numeral symbols with their corresponding decimal values. The `roman_helper` function recursively processes the number and symbols list, building the Roman numeral representation by appending the corresponding symbol to the result list while reducing the number by its decimal value.

**Task 17** -- Prime factorization

```elixir
  def factorize(n) do
    if n==1 do
      []
    else
      factorize(n, 2)
    end
  end

  defp factorize(n, i) do
    if isPrime(i) and rem(n, i) == 0 do
      [i | factorize(round(n / i), i)]
    else
      factorize(n, i + 1)
    end
  end
```

`factorize` function returns a list of prime factors of a given integer n. If n is 1, an empty list is returned. The factorize function calls a private function factorize(n, i) with a starting value of i=2, which recursively checks if i is a prime factor of n and appends it to the list if it is, or increases i and calls the function again if it is not.

## P0W3

**Task 1** -- Actor that prints any message it receives

```elixir
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
```

`PrintActor` receives a message and prints it while being in an infinite loop of listening for messages.

**Task 2** -- Actor that prints any message it receives, while modifying it

```elixir
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
```

`ModifyActor` receives a message and modifies it. It uses pattern matching to check if the message is an integer (then it adds 1 to it) or a bitstring (then it prints it to lowercase). If it is, it prints the message. Otherwise, it prints a message saying that it doesn't know how to handle the message.

**Task 3** -- An actor monitoring the other with a notification in case of termination

```elixir
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
```

The `MonitoringActor` sets up a loop function to monitor the `MonitoredActor`. When the `MonitoredActor` receives a stop message, it prints a message to the console and terminates. The `MonitoringActor` prints a message to the console when it detects that the `MonitoredActor` has stopped due to any reason.

**Task 4** -- Actor that with each request prints the current average of numbers

```elixir
defmodule Average do
  def loop(sum) do
    loop(sum, 0)
  end

  def loop(sum, count) do
    receive do
      value when is_integer(value) ->
        sum = sum+value
        count = count+1
        IO.puts("Current average is: #{sum/count}")
        loop(sum, count)
    end
  end
end
```

`Averager` receives a number and returns the average of the numbers it has received so far. It uses pattern matching to check if the message is an integer. If it is, it adds the number to the sum and increments the count. It then prints the average and calls `loop` with the new sum and count.

**Task 5** -- Actor which maintains a simple FIFO queue

```elixir
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
```

`Queue` module implements a queue data structure using the actor model. The `new_queue` function spawns a new process that starts the `loop` function with an empty queue. The `push` function sends a `{:push, value}` message to the process, which adds the value to the end of the queue. The `pop` function sends a `{:pop, sender}` message to the process, which removes the first element from the queue and sends it back to the sender. If the queue is empty, it sends a `:empty` message to the sender.

**Task 6** -- Actor implementing a semaphore

```elixir
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
```

`Semaphore` provides three functions to create a new semaphore, acquire and release the semaphore. The `create_semaphore` function creates a new semaphore with an optional initial count. The `acquire` function waits until the semaphore has a count greater than zero, then decrements the count and returns `:ok`. The `release` function increments the semaphore count. The semaphore state is maintained by the `loop` function which waits for messages to acquire or release the semaphore and updates the count accordingly.

**Task 7** -- Scheduler actor performing some risky business

```elixir
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
    if :rand.uniform() < 0.5 do
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
```

`Schedule` allows the creation of a process scheduler with a single `create_scheduler` function. Tasks can be scheduled to run by sending a message to the scheduler process with the `schedule(pid, task)` function, where `pid` is the process ID of the scheduler and task is any data representing the `task` to be executed. The `attempt_task(task)` function is called when a task is executed, and exits with either a normal exit or an error, depending on a random coin flip. If the task exits normally, the message "Task successful: Miau" is printed to the console. If the task exits with an error, the message "Task fail" is printed to the console, and a new worker is spawned to retry the task. The scheduler process runs indefinitely in a loop, waiting for new tasks to be scheduled or for workers to exit.

## P0W4

**Task 1** -- Supervised pool of identical worker actors

```elixir
defmodule MySup do
  use Supervisor

  def start_link(num_workers) do
    Supervisor.start_link(__MODULE__, num_workers: num_workers, name: __MODULE__)
    |> elem(1)
  end

  def init(args) do
    children = Enum.map(1..args[:num_workers], fn i ->
      %{
        id: i,
        start: {Worker, :start_link, []}
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker_pid(pid, id) do
    Supervisor.which_children(pid)
    |> Enum.find(fn {i, _, _, _} -> i == id end)
    |> elem(1)
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end

  def kill(pid, id) do
    Supervisor.terminate_child(pid, id)
  end

  def restart(pid, id) do
    Supervisor.restart_child(pid, id)
  end
end

defmodule Worker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def call(pid, msg) do
    GenServer.call(pid, msg)
  end

  def kill(pid) do
    GenServer.cast(pid, :kill)
  end

  def init(state) do
    {:ok, state}
  end

  def print(pid, msg) do
    GenServer.call(pid, msg)
  end

  def handle_call(msg, _from, state) do
    {:reply, msg, state}
  end

  def handle_cast(:kill, state) do
    {:stop, :killed, state}
  end
end
```

`MySup` is a supervisor module that manages a group of workers defined by the `num_workers` parameter provided in the `start_link` function. The supervisor uses a one-for-one strategy to restart the workers if they fail. The `get_worker_pid`, `count`, `kill`, and `restart` functions are helper functions that manipulate the state of the supervisor and its workers.

The `Worker` module defines a generic server. It has functions to start a new worker process `start_link`. In this implementation, Worker simply responds with the message it receives, and it can be "killed" by sending it a `:kill` message.

**Task 2** -- Supervised processing line to clean messy strings

```elixir
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
```

The `StringProcessor` module starts a supervisor with three child workers: `SplitWorker`, `ReplaceWorker`, and `JoinWorker`. The `process` function of `StringProcessor` takes a string as input, passes it to `SplitWorker.split`, which splits the string into words, passes the result to `ReplaceWorker.replace`, which replaces all occurrences of `m` with `n` and vice versa, and then passes the result to `JoinWorker.join`, which joins the words back into a single string.

The `SplitWorker`, `ReplaceWorker`, and `JoinWorker` modules use the `GenServer` behavior. Each one has a `start_link` function to start a process for the module, and a `handle_call` function to handle incoming messages.

**Task 3** -- Supervised application to simulate a sensor system in a car

```elixir
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
```

`CarSensorSystem` defines a car sensor system, consisting of several processes that monitor various aspects of a car, such as the `wheels`, `motor`, `cabin`, `chassis`, and `airbag`. The processes are supervised by a supervisor process, which automatically restarts them if they crash. It defines several functions for managing the system, including:

- `start_link`(num_wheels): Starts the supervisor process and its child processes, including a number of WheelSensor processes equal to num_wheels, as well as several other processes for monitoring different parts of the car. Returns the PID of the supervisor process.
- `get_wheel_pid`(pid, id): Given the PID of the supervisor process and an ID for a WheelSensor process, returns the PID of that WheelSensor process.
- `restart`(pid, id): Restarts the child process with the given id under the given supervisor pid.
- `count`(pid): Returns the number of child processes currently running under the given supervisor pid.
- `health`(pid, count): Monitors the health of the system by counting the number of crashes that occur in the child processes. If more than two crashes occur, it triggers the Airbag process to deploy and returns :ok. Otherwise, it randomly selects a child process and kills it, then recursively calls itself with an incremented crash count.
- `kill`(pid, id): Terminates the child process with the given id under the given supervisor pid.

The `WheelSensor`, `MotorSensor`, `CabinSensor`, and `ChassisSensor` modules define processes that monitor their respective parts of the car. Each module defines a `start_link` function for starting the process, an `init` function for initializing the process state, and a `crash` function that simulates a crash by calling the `handle_info` function with the `:crash` atom. The `handle_info` function logs a warning message indicating that the process has crashed and returns `{:restart, :temporary, state}`, which tells the supervisor to restart the process temporarily.

The `Airbag` module defines a process that handles the deployment of the car's airbag. It also defines a `start_link` function for starting the process and an `init` function for initializing the process state. It also defines a `handle_info` function that handles the `:deploy` atom, which simply returns `{:noreply, state}`. The `health` function in the CarSensorSystem module triggers the Airbag process to deploy when the crash count exceeds two.

**Task 4** -- Pulp Fiction

```elixir
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
```

The `Pulp` module is a supervisor that starts two child processes: `Samuel` and `Dude`. The supervisor uses a `"one for all"` strategy. Pulp also defines two functions, `loop` and `count`, which respectively keep calling `Samuel.ask()` and return the number of children currently being supervised.

The `Samuel` module is a `GenServer` process that responds to calls to the ask function. When called, it sleeps for 1.5 seconds, outputs `"Samuel Jackson: Where is the money Lebowski?"` to the console, and then calls the `Dude.answer` function. In case the answer is "What?" 2 times, Samuel will warn Dude with `""Samuel Jackson: I double dare you to say what one more time."` and if it happens for the third time, well... that's gonna be the last time for `Dude`.

The `Dude` module is another `GenServer` process that responds to calls to the `answer` function and to `cast` messages to `kill` the process. When called, it sleeps for 2 seconds and outputs `"Lebowski: I think it's down there let me have another look."` to the console. With `30%` chance, it may return the string `"Ok"` or the string `"What?"`. When a `kill` cast message is received, it stops itself with a normal exit status.

## P0W5

**Task 1** -- Quotes Web Scraper

```elixir
defmodule Quotes do
  @url "https://quotes.toscrape.com/"

  defp get_request() do
    HTTPoison.get!(@url)
  end

  def init do
    response = get_request()

    print_response(response)

    quotes = extract_quotes(response.body)

    write_to_file(quotes)
  end

  defp print_response(response) do
    IO.puts("Response status_code : #{response.status_code}")
    IO.inspect(response.headers, label: "Response headers")
    IO.puts("Response body : #{response.body}")
  end

  defp extract_quotes(body) do
    {:ok, html} = Floki.parse_document(body)
    quotes = Floki.find(html, ".quote")
    Enum.map(quotes, fn quote ->
      author = extract_author(quote)
      text = extract_text(quote)
      tags = extract_tags(quote)
      IO.inspect(%{author: author, text: text, tags: tags})
    end)
  end

  defp write_to_file(quotes) do
    File.write!("quotes.json", Jason.encode!(quotes))
  end

  defp extract_author(quote) do
    Floki.find(quote, ".author") |> hd() |> Floki.text()
  end

  defp extract_text(quote) do
    Floki.find(quote, ".text") |> hd() |> Floki.text()
  end

  defp extract_tags(quote) do
    Floki.find(quote, ".tag") |> Enum.map(&Floki.text/1)
  end
end
```
The `Quotes` module uses `HTTPoison` to send a get request to "https://quotes.toscrape.com/". In function `print_response` I print out the HTTP response status code, response headers and response body. In function `extract_quotes`, using Floki I find the quotes by searching `.quote` and by iterating over every quote, finding the author, text and tags using `Floki.find() |> hd() |> Floki.text()` to extract each separately. Writing to file is done with `Jason.encode()` in `quotes.json`. 

**Task 2** -- Star Wars API

```elixir
defmodule StarWarsApi do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: StarWarsApi.Router, options: [port: 8080]},
      {StarWarsApi.Repository, []}
    ]
    opts = [strategy: :one_for_one, name: StarWarsApi.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end

defmodule StarWarsApi.Router do
  use Plug.Router

  plug Plug.Parsers,
       parsers: [:urlencoded, :json],
       pass: ["*/*"],
       json_decoder: Jason

  plug :match
  plug :dispatch

  get "/movies" do
    movies = StarWarsApi.Repository.get_all_movies()
    send_resp(conn, 200, Jason.encode!(movies))
  end

  get "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = StarWarsApi.Repository.get_movie(id)
    send_resp(conn, 200, Jason.encode!(movie))
  end

  post "/movies" do
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.create_movie(movie)
    send_resp(conn, 201, Jason.encode!(new_movie))
  end

  put "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  patch "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  delete "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    StarWarsApi.Repository.delete_movie(id)
    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Path doesn't exist.")
  end
end

defmodule StarWarsApi.Repository do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    :ets.new(:movies_table, [:set, :public, :named_table])
    :ok = load_movies_into_table(:movies_table)
    {:ok, :movies_table}
  end

  defp load_movies_into_table(table) do
    movies = [
      %{
        id: 1,
        title: "Star Wars: Episode IV - A New Hope",
        director: "George Lucas",
        release_year: 1977
      },
      %{
        id: 2,
        title: "Star Wars: Episode V - The Empire Strikes Back",
        director: "Irvin Kershner",
        release_year: 1980
      },
      %{
        id: 3,
        title: "Star Wars: Episode VI - Return of the Jedi",
        director: "Richard Marquand",
        release_year: 1983
      },
      %{
        id: 4,
        title: "Star Wars: Episode I - The Phantom Menace",
        director: "George Lucas",
        release_year: 1999
      },
      %{
        id: 5,
        title: "Star Wars: Episode II - Attack of the Clones",
        director: "George Lucas",
        release_year: 2002
      },
      %{
        id: 6,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      },
      %{
        id: 7,
        title: "Star Wars: Episode VII - The Force Awakens",
        director: "J.J. Abrams",
        release_year: 2015
      },
      %{
        id: 8,
        title: "Star Wars: Episode VIII - The Last Jedi",
        director: "Rian Johnson",
        release_year: 2017
      },
      %{
        id: 9,
        title: "Star Wars: Episode IX - The Rise of Skywalker",
        director: "J.J. Abrams",
        release_year: 2019
      },
      %{
        id: 10,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      }
    ]

    Enum.each(movies, fn movie ->
      :ets.insert(table, {movie[:id], movie})
    end)
  end

  def handle_call(:get_all_movies, _from, table) do
    movies = Enum.map(:ets.tab2list(table), fn {key, movie} -> Map.put(movie, :id, key) end)
    {:reply, movies, table}
  end

  def handle_call({:get_movie, id}, _from, table) do
    movies = :ets.lookup(table, id)
    if length(movies) == 0 do
      {:reply, nil, table}
    else
      {key, movie} = List.first(movies)
      {:reply, %{movie | id: key}, table}
    end
  end

  def handle_call({:create_movie, movie}, _from, table) do
    id = :ets.info(table, :size) + 1
    Map.put(movie, :id, id)
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:update_movie, id, movie}, _from, table) do
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:delete_movie, id}, _from, table) do
    :ets.delete(table, id)
    {:reply, :ok, table}
  end

  def get_all_movies do
    GenServer.call(__MODULE__, :get_all_movies)
  end

  def get_movie(id) do
    GenServer.call(__MODULE__, {:get_movie, id})
  end

  def create_movie(movie) do
    GenServer.call(__MODULE__, {:create_movie, movie})
  end

  def update_movie(id, movie) do
    GenServer.call(__MODULE__, {:update_movie, id, movie})
  end

  def delete_movie(id) do
    GenServer.call(__MODULE__, {:delete_movie, id})
  end
end
```
`StarWarsApi` is an API that allows to get, create, update, and delete movies from an ETS table database. It is built using `Plug and Cowboy` which is defined in the `StarWarsApi.Router` module while database is defined in the `StarWarsApi.Repository` module. The database is started as a GenServer and is registered under the name StarWarsApi.Repository. The API uses the GenServer to access the database. The API is started as an Application and is registered under the name StarWarsApi. The API is started using the command `StarWarsApi.start(:normal, [])`.

## Conclusion
Overall, our laboratory work in functional programming with Elixir has been a challenging but rewarding experience. We started by learning the basics of the language, such as variables, functions, and control structures, and we gradually progressed to more advanced concepts, such as processes, message passing, and concurrency.

Throughout our work, we explored the actor model and its implementation in Elixir, using GenServer and Supervisor to create fault-tolerant and scalable systems. We also learned how to build complex applications with Elixir, using its built-in tools and libraries, such as Mix, HTTPoison, Floki, Poison, Application and Plug as well as ETS.

## Bibliography

1. [Elixir](https://elixir-lang.org/)
2. [Elixir Documentation](https://elixir-lang.org/docs.html)
3. [Supervisor](https://hexdocs.pm/elixir/Supervisor.html)
4. [GenServer](https://hexdocs.pm/elixir/GenServer.html)