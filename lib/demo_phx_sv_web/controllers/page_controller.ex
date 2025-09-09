defmodule DemoPhxSvWeb.PageController do
  use DemoPhxSvWeb, :controller

  def home(conn, _params) do
    render_inertia(conn, "Home", %{
      message: "Welcome to Phoenix + Inertia.js + Svelte 5!"
    })
  end
end
