defmodule LiveViewDemoWeb.ChatLive do
  use LiveViewDemoWeb, :live_view

  @topic "chat_room"

  def render(assigns) do
    ~H"""
      <div class="p-6 max-w-2xl mx-auto">
        <%= if @username == "" do %>
          <form phx-submit="set_username" class="space-y-4">
            <input
              type="text"
              name="username"
              placeholder="Enter your name"
              class="w-full p-3 border rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <button
              type="submit"
              class="w-full p-3 bg-blue-500 text-white rounded-md hover:bg-blue-600 focus:outline-none"
            >
              Join Chat
            </button>
          </form>
        <% else %>
          <div class="chat-box space-y-4 h-80 overflow-y-auto bg-gray-50 p-4 rounded-md border shadow-md mb-4">
            <%= for msg <- @messages do %>
              <div class="flex items-start space-x-2">
                <strong class="text-blue-600"><%= msg.user %>:</strong>
                <p><%= msg.body %></p>
              </div>
            <% end %>
          </div>

          <form phx-submit="send_message" class="flex space-x-2">
            <strong class="text-blue-600 flex items-center"><%= @username %>:</strong>
            <input
              type="text"
              name="message"
              value={@message}
              placeholder="Type a message"
              class="w-full p-3 border rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <button
              type="submit"
              class="p-3 bg-blue-500 text-white rounded-md hover:bg-blue-600 focus:outline-none"
            >
              Send
            </button>
          </form>
        <% end %>
      </div>
    """
  end

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(LiveViewDemo.PubSub, @topic)

    {:ok,
     assign(socket,
       messages: [],
       username: "",
       message: ""
     )}
  end

  def handle_event("set_username", %{"username" => username}, socket) do
    {:noreply, assign(socket, :username, username)}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    msg = %{user: socket.assigns.username, body: message}
    Phoenix.PubSub.broadcast(LiveViewDemo.PubSub, @topic, {:new_msg, msg})
    {:noreply, assign(socket, :message, "")}
  end

  def handle_info({:new_msg, msg}, socket) do
    {:noreply, update(socket, :messages, fn msgs -> [msg | msgs] end)}
  end
end
