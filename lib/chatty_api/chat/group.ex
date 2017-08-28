defmodule ChattyApi.Chat.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.Group


  schema "groups" do
    field :name, :string
    has_many :messages, ChattyApi.Chat.Message
    many_to_many :users, ChattyApi.Account.User, join_through: "group_users", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
