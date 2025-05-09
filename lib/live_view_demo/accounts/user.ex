defmodule LiveViewDemo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias LiveViewDemo.Repo

  schema "users" do
    field :username, :string
    field :password, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 3, max: 20)
    |> validate_length(:password, min: 6)
    |> unsafe_validate_unique(:username, Repo)
    |> unique_constraint(:username)
  end
end
