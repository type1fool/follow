defmodule Follow.Subscriptions.Events.Created do
  @derive Jason.Encoder
  defstruct [:user_id, :initial_status]
end

defmodule Follow.Subscriptions.Events.Updated do
  @derive Jason.Encoder
  defstruct [:user_id, :new_status]
end
