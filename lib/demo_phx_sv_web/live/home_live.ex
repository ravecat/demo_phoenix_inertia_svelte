defmodule DemoPhxSvWeb.HomeLive do
  use DemoPhxSvWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "Welcome to Phoenix LiveView!", counter: 0)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen flex items-center justify-center bg-base-200">
      <div class="text-center max-w-lg w-full px-4">
        <h1 class="text-5xl font-bold mb-6">LiveView Demo</h1>
        <p class="text-lg mb-8">{@message}</p>
        <div class="flex flex-col gap-4">
          <button class="btn btn-primary w-48 mx-auto" phx-click="increment">
            Click Me! ({@counter})
          </button>
          <a href="/" class="btn btn-secondary w-48 mx-auto">
            Inertia Page
          </a>
          <a
            href="https://hexdocs.pm/phoenix_live_view/"
            class="btn btn-outline w-48 mx-auto"
            target="_blank"
          >
            Learn More
          </a>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, counter: socket.assigns.counter + 1)}
  end
end
