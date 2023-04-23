defmodule Follow.SubscriptionAggregate do
  @moduledoc """
  A struct representing a subscription.
  """
  alias Follow.CreateSubscriptionCommand
  alias Follow.UpdateSubscriptionCommand
  alias Follow.SubscriptionCreatedEvent
  alias Follow.SubscriptionUpdatedEvent

  @statuses [:trial, :active, :inactive, :suspended, :locked]
  defguard is_status(status) when status in @statuses

  def get_statuses, do: @statuses

  defstruct [:user_id, :status]

  # API

  def execute(%__MODULE__{user_id: nil}, %CreateSubscriptionCommand{
        user_id: user_id,
        initial_status: initial_status
      })
      when is_status(initial_status) do
    %SubscriptionCreatedEvent{user_id: user_id, initial_status: initial_status}
  end

  def execute(%__MODULE__{}, %CreateSubscriptionCommand{initial_status: initial_status})
      when initial_status not in [:trial, :active] do
    {:error, :invalid_status}
  end

  def execute(%__MODULE__{}, %CreateSubscriptionCommand{}) do
    {:error, :subscription_already_created}
  end

  def execute(%__MODULE__{}, %UpdateSubscriptionCommand{user_id: user_id, new_status: new_status}) do
    %SubscriptionUpdatedEvent{user_id: user_id, new_status: new_status}
  end

  # MUTATORS

  def apply(%__MODULE__{} = subscription, %SubscriptionCreatedEvent{} = event) do
    %{user_id: user_id, initial_status: initial_status} = event

    %__MODULE__{subscription | user_id: user_id, status: initial_status}
  end

  def apply(%__MODULE__{} = subscription, %SubscriptionUpdatedEvent{} = event) do
    %{user_id: user_id, new_status: new_status} = event

    %__MODULE__{subscription | user_id: user_id, status: new_status}
  end
end
