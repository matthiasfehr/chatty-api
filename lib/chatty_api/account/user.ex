defmodule ChattyApi.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Account.User


  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    has_many :messages, ChattyApi.Chat.Message
    many_to_many :groups, ChattyApi.Chat.Group, join_through: "group_users", on_delete: :delete_all
    many_to_many :friends, ChattyApi.Account.User, join_through: ChattyApi.Chat.Friend, join_keys: [user_id: :id, friend_id: :id]
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> unique_constraint(:email, message: "Email is already taken")
  end
end
