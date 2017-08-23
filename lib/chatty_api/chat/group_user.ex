defmodule ChattyApi.Chat.GroupUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.GroupUser


  schema "group_users" do
#    field :user_id, :id
#    field :group_id, :id
    belongs_to :user, ChattyApi.Account.User, foreign_key: :user_id
    belongs_to :group, ChattyApi.Chat.Group, foreign_key: :group_id

    timestamps()
  end

  @doc false
  def changeset(%GroupUser{} = group_user, attrs) do
    group_user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
