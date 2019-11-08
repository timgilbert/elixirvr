defmodule Elixirvr do
  @moduledoc """
  Documentation for Elixirvr.
  """

  require Constants

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
    {:ok, pid} = Circuits.UART.start_link
    Circuits.UART.open(pid, "/dev/cu.SLAB_USBtoUART", speed: 115200, active: false)
  end

  # @spec escape(bitstring) :: [<<_::16>> | byte]
  def escape(binary) do
    for <<byte::8 <- binary>> do
      case byte do
        Constants.packet(:start) ->
          <<Constants.packet(:escape), Constants.escaped(:start)>>
        Constants.packet(:last) ->
          <<Constants.packet(:escape), Constants.escaped(:last)>>
        Constants.packet(:escape) ->
          <<Constants.packet(:escape), Constants.escaped(:escape)>>
        _ -> byte
      end
    end
  end
end
