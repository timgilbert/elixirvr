defmodule Elixirvr do
  @moduledoc """
  Documentation for Elixirvr.
  """

  import Constants, only: [packet: 1, escaped: 1]

  @doc """
  Hello world.

  ## Examples

      iex> Elixirvr.hello()
      :world

  """
  def hello do
    :world
  end

  @spec go :: :ok | {:error, any}
  def go do
    {:ok, pid} = Circuits.UART.start_link()
    Circuits.UART.open(pid, "/dev/cu.SLAB_USBtoUART", speed: 115_200, active: false)
  end

  @spec escape(binary()) :: binary()
  def escape(binary) do
    for <<byte::8 <- binary>> do
      case byte do
        packet(:start) -> <<packet(:escape), escaped(:start)>>
        packet(:last) -> <<packet(:escape), escaped(:last)>>
        packet(:escape) -> <<packet(:escape), escaped(:escape)>>
        _ -> byte
      end
    end
    |> :binary.list_to_bin()
  end

  @spec unescape(binary()) :: binary()
  def unescape(<<first::8, second::8, rest::binary>>) do
    result =
      case {first, second} do
        {packet(:escape), escaped(:start)} ->  packet(:start)
        {packet(:escape), escaped(:last)} -> packet(:last)
        {packet(:escape), escaped(:escape)} -> packet(:escape)
        _ -> <<first>>
      end

    <<result, second <> rest>>
  end
end
