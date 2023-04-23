defmodule Follow.Subscriptions.Projection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Follow.Subscriptions.Aggregate

  @statuses Aggregate.get_statuses()

  @primary_key {:user_id, :id, autogenerate: false}
  schema "subscription_projections" do
    field :status, Ecto.Enum, values: @statuses
  end

  def changeset(%__MODULE__{} = data, attrs) do
    data
    |> cast(attrs, [:user_id, :status])
    |> validate_required(__MODULE__.__schema__(:fields))
  end
end
