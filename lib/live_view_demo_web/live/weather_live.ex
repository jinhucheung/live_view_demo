defmodule LiveViewDemoWeb.WeatherLive do
  use LiveViewDemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <form phx-submit="set-location">
        <input name="location" placeholder="Location" value={@location}/>
        <%= @weather %>
      </form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, location: nil, weather: "...")}
  end

  def handle_event("set-location", %{"location" => location}, socket) do
    {:noreply, assign(socket, location: location, weather: weather(location))}
  end

  defp weather(local) do
    {:ok, {{_, 200, _}, _, body}} =
      :httpc.request(:get, {~c"http://wttr.in/#{URI.encode(local)}?format=1", []}, [], [])
    IO.iodata_to_binary(body)
  end
end
