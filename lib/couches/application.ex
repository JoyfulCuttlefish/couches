defmodule Couches.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CouchesWeb.Telemetry,
      Couches.Repo,
      {DNSCluster, query: Application.get_env(:couches, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Couches.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Couches.Finch},
      # Start a worker by calling: Couches.Worker.start_link(arg)
      # {Couches.Worker, arg},
      # Start to serve requests, typically the last entry
      CouchesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Couches.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CouchesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
