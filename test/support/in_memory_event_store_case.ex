defmodule Follow.InMemoryEventStoreCase do
  use ExUnit.CaseTemplate

  alias Commanded.EventStore.Adapters.InMemory

  setup do
    {:ok, _} = Application.ensure_all_started(:follow)

    on_exit(fn ->
      :ok = Application.stop(:follow)
    end)

    :ok
  end
end
