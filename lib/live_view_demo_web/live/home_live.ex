defmodule LiveViewDemoWeb.HomeLive do
  use LiveViewDemoWeb, :live_view

  def render(assigns) do
    ~H"""
      <div class="mt-10 grid grid-cols-1 gap-y-4 text-lg leading-6 text-zinc-700 sm:grid-cols-2">
        <div>
          <.link navigate={~p"/chat"} class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900">
            <svg
              viewBox="0 0 16 16"
              aria-hidden="true"
              class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
            >
              <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
            </svg>

            Chat
          </.link>
        </div>
      </div>
    """
  end
end
