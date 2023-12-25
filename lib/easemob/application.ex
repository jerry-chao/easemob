defmodule Easemob.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EasemobWeb.Telemetry,
      # Start the Ecto repository
      Easemob.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Easemob.PubSub},
      # Start Finch
      {Finch, name: Easemob.Finch},
      # Start the Endpoint (http/https)
      EasemobWeb.Endpoint
      # Start a worker by calling: Easemob.Worker.start_link(arg)
      # {Easemob.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Easemob.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EasemobWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
