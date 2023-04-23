defmodule Follow.Subscriptions.Commands do
  @moduledoc """
  Subscription command structs.
  """
  defmodule Create do
    defstruct [:user_id, :initial_status]
  end

  defmodule Update do
    defstruct [:user_id, :new_status]
  end
end
