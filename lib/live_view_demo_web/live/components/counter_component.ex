defmodule LiveViewDemoWeb.Components.CounterComponent do
  use LiveViewDemoWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="border p-4 rounded shadow w-64">
        <p class="mb-2">Count: <%= @count %></p>
        <div class="flex gap-2">
          <button phx-click="inc" phx-target={@myself}
                  class="bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600">
            +1
          </button>
          <button phx-click="reset" phx-target={@myself}
                  class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600">
            Reset
          </button>
        </div>
      </div>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, :count, 0)}
  end
end
