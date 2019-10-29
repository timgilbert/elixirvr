defmodule ElixirvrTest do
  use ExUnit.Case
  doctest Elixirvr

  test "greets the world" do
    assert Elixirvr.hello() == :world
  end
end
