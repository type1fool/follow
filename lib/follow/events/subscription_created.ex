defmodule Follow.SubscriptionCreatedEvent do
  @derive Jason.Encoder
  defstruct [:user_id, :initial_status]
end
