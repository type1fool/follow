defmodule Follow.SubscriptionHandler do
  use Commanded.Event.Handler,
    application: Follow.Events,
    name: __MODULE__

  alias Follow.SubscriptionCreatedEvent
  alias Follow.SubscriptionUpdatedEvent

  def init do
    with {:ok, _pid} <- Agent.start_link(fn -> :inactive end, name: __MODULE__) do
      :ok
    end
  end

  def handle(%SubscriptionCreatedEvent{initial_status: initial_status}, _metadata) do
    Agent.update(__MODULE__, fn _ -> initial_status end)
  end

  def handle(%SubscriptionUpdatedEvent{new_status: new_status}, _metadata) do
    Agent.update(__MODULE__, fn _ -> new_status end)
  end

  def current_status do
    Agent.get(__MODULE__, & &1)
  end
end
