defmodule Follow.Accounts.Subscription do
  @moduledoc """
  A struct representing a subscription.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @statuses [:new, :active, :inactive, :suspended, :locked, :deleted]
  @type status :: :new | :active | :inactive | :suspended | :locked | :deleted
  defguard is_status(status) when status in @statuses

  @derive Jason.Encoder
  @primary_key false
  schema "subscriptions" do
    field :user_id, :id
    field :status, Ecto.Enum, values: @statuses
  end

  def changeset(%__MODULE__{} = data, attrs \\ %{}) do
    data
    |> cast(attrs, [:user_id, :status])
    |> validate_required(__MODULE__.__schema__(:fields))
    |> validate_number(:user_id, greater_than: 0)
    |> validate_inclusion(:status, @statuses)
  end
end
