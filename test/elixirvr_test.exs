defmodule ElixirvrTest do
  use ExUnit.Case
  doctest Elixirvr

  # test "greets the world" do
  #   assert Elixirvr.hello() == :world
  # end

  test "escape stuff" do
    assert Elixirvr.escape(<<0x00>>) == <<0x00>>
    assert Elixirvr.escape(<<0x8D>>) == <<0xAB, 0x05>>
  end

  test "unescape stuff" do
    assert Elixirvr.unescape(<<0x00>>) == <<0x00>>
    assert Elixirvr.unescape(<<0xAB, 0x05>>) == <<0x8D>>
  end
end
