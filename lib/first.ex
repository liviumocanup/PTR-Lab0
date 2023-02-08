defmodule First do
  def hello do
    IO.puts("Hello PTR")
  end

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

  def cylinderArea(h, r) when h>0 and r>0 do
    2 * :math.pi * r * (r + h)
  end

  def cylinderArea(_, _) do
    -1
  end

  def reverse(list) do
    Enum.reverse(list)
  end

  def uniqueSum(list) do
    Enum.uniq(list) |> Enum.sum()
  end

  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end

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

  def translator(dictionary, text) do
    words = Enum.map(String.split(text, " "), fn word -> Map.get(dictionary, String.to_atom(word), word) end)
    Enum.join(words, " ")
  end

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


  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

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

  def groupAnagrams(words) do
    Enum.group_by(words, fn word -> String.trim(word)
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
    |> List.to_string end)
  end

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
end

#First.hello
#IO.inspect(First.isPrime(2))
#IO.inspect(First.cylinderArea(3, 4))
#IO.inspect(First.reverse([1, 2, 4, 8, 4]))
#IO.inspect(First.uniqueSum([1, 2, 4, 8, 4, 2]))
#IO.inspect(First.extractRandomN([1, 2, 4, 8, 4], 3))
#IO.inspect(First.firstFibonacciElements(7))

#dictionary = %{"mama": "mother", "papa": "father"}
#original_string = "mama is with papa"
#IO.inspect(First.translator(dictionary, original_string))

#IO.inspect(First.rotateLeft([1, 2, 4, 8, 4], 3))
#IO.inspect(First.smallestNumber(0, 3, 4))
#IO.inspect(First.lastRightAngleTriangles)

#IO.inspect(First.removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4]))
#IO.inspect(First.lineWords(["Hello", "Alaska", "Dad", "Peace"]))
#IO.inspect(First.encode("hello", 3))
#IO.inspect(First.decode("khoor", 3))
#IO.inspect(First.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
#IO.inspect(First.arabic_to_roman(13))
#IO.inspect(First.longest_common_prefix(["flower", "flow", "flight"]))
#IO.inspect(First.factorize(42))
