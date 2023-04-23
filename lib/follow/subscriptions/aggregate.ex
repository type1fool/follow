defmodule Follow.Subscriptions.Aggregate do
  @moduledoc """
  A struct representing a subscription.
  """
  alias Follow.Subscriptions.Commands.Create
  alias Follow.Subscriptions.Commands.Update
  alias Follow.Subscriptions.Events.Created
  alias Follow.Subscriptions.Events.Updated

  @statuses [:trial, :active, :inactive, :suspended, :locked]
  defguard is_status(status) when status in @statuses

  def get_statuses, do: @statuses

  defstruct [:user_id, :status]

  # API

  def execute(%__MODULE__{user_id: nil}, %Create{
        user_id: user_id,
        initial_status: initial_status
      })
      when is_status(initial_status) do
    %Created{user_id: user_id, initial_status: initial_status}
  end

  def execute(%__MODULE__{}, %Create{initial_status: initial_status})
      when initial_status not in [:trial, :active] do
    {:error, :invalid_status}
  end

  def execute(%__MODULE__{}, %Create{}) do
    {:error, :subscription_already_created}
  end

  def execute(%__MODULE__{}, %Update{user_id: user_id, new_status: new_status}) do
    %Updated{user_id: user_id, new_status: new_status}
  end

  # MUTATORS

  def apply(%__MODULE__{} = subscription, %Created{} = event) do
    %{user_id: user_id, initial_status: initial_status} = event

    %__MODULE__{subscription | user_id: user_id, status: initial_status}
  end

  def apply(%__MODULE__{} = subscription, %Updated{} = event) do
    %{user_id: user_id, new_status: new_status} = event

    %__MODULE__{subscription | user_id: user_id, status: new_status}
  end
end
