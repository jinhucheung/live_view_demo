defmodule LiveViewDemoWeb.TodoLive do
  use LiveViewDemoWeb, :live_view
  import Ecto.Query

  alias LiveViewDemo.Task
  alias LiveViewDemo.Repo

  @topic "todo"

  def render(assigns) do
    ~H"""
      <div class="max-w-md mx-auto mt-10 p-4 border rounded">
        <h2 class="text-2xl font-bold mb-4">Todo List</h2>

        <form phx-submit="add">
          <input type="text" name="title" value={@title}
                class="border p-2 w-full mb-2" placeholder="New task..." />
          <button class="bg-blue-500 text-white px-4 py-1 rounded">Add</button>
        </form>

        <ul class="mt-4 space-y-2">
          <%= for task <- @tasks do %>
            <li class="flex justify-between items-center border p-2 rounded">
              <div class="flex items-center space-x-2">
                <input type="checkbox"
                      phx-click="toggle"
                      phx-value-id={task.id}
                      checked={task.completed} />
                <span class={if task.completed, do: "line-through text-gray-500", else: ""}>
                  <%= task.title %>
                </span>
              </div>
              <button phx-click="delete" phx-value-id={task.id}
                      class="text-red-500 hover:underline">Delete</button>
            </li>
          <% end %>
        </ul>
      </div>
    """
  end

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(LiveViewDemo.PubSub, @topic)

    {:ok, assign(socket, tasks: list_tasks(), title: "")}
  end

  def handle_event("add", %{"title" => title}, socket) do
    if String.trim(title) != "" do
      %Task{title: title, completed: false}
      |> Repo.insert()
      Phoenix.PubSub.broadcast(LiveViewDemo.PubSub, @topic, :tasks_updated)
    end
    {:noreply, assign(socket, tasks: list_tasks(), title: "")}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    task = Repo.get!(Task, id)
    Repo.delete!(task)
    Phoenix.PubSub.broadcast(LiveViewDemo.PubSub, @topic, :tasks_updated)
    {:noreply, assign(socket, tasks: list_tasks())}
  end

  def handle_event("toggle", %{"id" => id}, socket) do
    task = Repo.get!(Task, id)
    {:ok, _} =
      task
      |> Ecto.Changeset.change(completed: !task.completed)
      |> Repo.update()

    Phoenix.PubSub.broadcast(LiveViewDemo.PubSub, @topic, :tasks_updated)
    {:noreply, assign(socket, tasks: list_tasks())}
  end

  def handle_info(:tasks_updated, socket) do
    {:noreply, assign(socket, tasks: list_tasks())}
  end

  defp list_tasks do
    Repo.all(from t in Task, order_by: [desc: t.inserted_at])
  end
end
