defmodule DemoPhoenixInertiaSvelteWeb.PageController do
  use DemoPhoenixInertiaSvelteWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def inertia(conn, _params) do
    inertia_version = "2.0.12"
    svelte_version = "5.33.19"
    phoenix_version = to_string(Application.spec(:phoenix, :vsn))

    conn
    |> assign_prop(:inertia_version, inertia_version)
    |> assign_prop(:svelte_version, svelte_version)
    |> assign_prop(:phoenix_version, phoenix_version)
    |> render_inertia("Home", ssr: true)
    |> dbg
  end
end
