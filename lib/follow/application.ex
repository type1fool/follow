defmodule Follow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  use Commanded.Application, otp_app: :follow

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FollowWeb.Telemetry,
      # Start the Ecto repository
      Follow.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Follow.PubSub},
      # Start Finch
      {Finch, name: Follow.Finch},
      # Start the Endpoint (http/https)
      FollowWeb.Endpoint
      # Start a worker by calling: Follow.Worker.start_link(arg)
      # {Follow.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Follow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FollowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end