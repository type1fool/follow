defmodule Follow.SubscriptionUpdatedEvent do
  @derive Jason.Encoder
  defstruct [:user_id, :new_status]
end
