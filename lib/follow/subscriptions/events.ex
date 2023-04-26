defmodule Follow.Subscriptions.Events do
  @moduledoc """
  Subscription event structs.
  """

  defmodule Created do
    @derive Jason.Encoder
    defstruct [:user_id, :initial_status]
  end

  defmodule Updated do
    @derive Jason.Encoder
    defstruct [:user_id, :new_status]
  end
end
