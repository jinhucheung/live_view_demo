defmodule LiveViewDemoWeb.RegistrationLive do
  use LiveViewDemoWeb, :live_view

  alias LiveViewDemo.Accounts.User
  alias LiveViewDemo.Repo

  def render(assigns) do
    ~H"""
      <.simple_form
        for={@changeset}
        as={:user}
        id="registration_form"
        phx-change="validate"
        phx-submit="save"
        class="space-y-6"
        :let={f}
      >
        <.input field={f[:username]} label="Username" />
        <.input field={f[:password]} type="password" label="Password" />

        <:actions>
          <.button phx-disable-with="Registering..." class="w-full">
            Register
          </.button>
        </:actions>
      </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: User.changeset(%User{}, %{}))}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> User.changeset(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Repo.insert(User.changeset(%User{}, user_params)) do
      {:ok, _user} ->
        socket = put_flash(socket, :info, "Registration successful!")
        {:noreply, push_navigate(socket, to: "/")}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
