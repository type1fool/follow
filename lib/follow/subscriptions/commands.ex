defmodule Follow.Subscriptions.Commands.Create do
  defstruct [:user_id, :initial_status]
end

defmodule Follow.Subscriptions.Commands.Update do
  defstruct [:user_id, :new_status]
end
