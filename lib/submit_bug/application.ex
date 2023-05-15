defmodule SubmitBug.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SubmitBugWeb.Telemetry,
      # Start the Ecto repository
      SubmitBug.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SubmitBug.PubSub},
      # Start Finch
      {Finch, name: SubmitBug.Finch},
      # Start the Endpoint (http/https)
      SubmitBugWeb.Endpoint
      # Start a worker by calling: SubmitBug.Worker.start_link(arg)
      # {SubmitBug.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SubmitBug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SubmitBugWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
