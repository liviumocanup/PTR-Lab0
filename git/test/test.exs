defmodule FirstTest do
  use ExUnit.Case
  doctest First

  test "hello" do
    assert First.hello() == "Hello, PTR!"
  end
end
