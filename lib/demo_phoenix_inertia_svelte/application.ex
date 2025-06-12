defmodule DemoPhoenixInertiaSvelte.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DemoPhoenixInertiaSvelteWeb.Telemetry,
      DemoPhoenixInertiaSvelte.Repo,
      {DNSCluster, query: Application.get_env(:demo_phoenix_inertia_svelte, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DemoPhoenixInertiaSvelte.PubSub},
      # Start a worker by calling: DemoPhoenixInertiaSvelte.Worker.start_link(arg)
      # {DemoPhoenixInertiaSvelte.Worker, arg},
      # Start to serve requests, typically the last entry
      DemoPhoenixInertiaSvelteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DemoPhoenixInertiaSvelte.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoPhoenixInertiaSvelteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
