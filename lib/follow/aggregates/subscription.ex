defmodule Follow.Aggregates.Subscription do
  @moduledoc """
  A struct representing a subscription.
  """
  alias Follow.Commands.CreateSubscription
  alias Follow.Events.SubscriptionCreated

  @statuses [:trial, :active, :inactive, :suspended, :locked]
  defguard is_status(status) when status in @statuses

  defstruct [:user_id, :status]

  # API

  def execute(%__MODULE__{user_id: nil}, %CreateSubscription{
        user_id: user_id,
        initial_status: initial_status
      })
      when is_status(initial_status) do
    %SubscriptionCreated{user_id: user_id, initial_status: initial_status}
  end

  def execute(%__MODULE__{}, %CreateSubscription{initial_status: initial_status})
      when initial_status not in [:trial, :active] do
    {:error, :invalid_status}
  end

  def execute(%__MODULE__{}, %CreateSubscription{}) do
    {:error, :subscription_already_created}
  end

  # MUTATORS

  def apply(%__MODULE__{} = subscription, %SubscriptionCreated{} = event) do
    %{user_id: user_id, initial_status: initial_status} = event

    %__MODULE__{subscription | user_id: user_id, status: initial_status}
  end
end
