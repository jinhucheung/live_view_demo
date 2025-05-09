defmodule LiveViewDemoWeb.CounterLive do
  use LiveViewDemoWeb, :live_view

  def render(assigns) do
    ~H"""
      <div class="space-y-4">
        <%= for id <- @counters do %>
          <.live_component module={LiveViewDemoWeb.Components.CounterComponent} id={"counter-#{id}"} />
        <% end %>
      </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, counters: [1, 2, 3])}
  end
end
