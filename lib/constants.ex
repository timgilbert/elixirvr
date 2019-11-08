defmodule Constants do
  @moduledoc """
  Constants for talking to the RVR.
  """
  use Const

  # https://github.com/sphero-inc/sphero-sdk-raspberrypi-python/blob/master/sphero_sdk/common/protocol/api_sphero_message.py#L14-L19
  enum packet do
    start  0x8d
    last   0xd8
    escape 0xab
  end

  enum escaped do
    start  0x05
    last   0x50
    escape 0x23
  end
end
