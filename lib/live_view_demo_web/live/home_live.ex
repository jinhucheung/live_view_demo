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
        <div>
          <.link navigate={~p"/weather"} class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z" />
            </svg>

            Weather
          </.link>
        </div>
      </div>
    """
  end
end
