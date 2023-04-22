defmodule Follow.Events.SubscriptionCreated do
  @derive Jason.Encoder
  defstruct [:user_id, :initial_status]
end
