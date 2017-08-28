defmodule ChattyApi.Chat.GroupUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.GroupUser


  schema "group_users" do
    belongs_to :user, ChattyApi.Account.User, foreign_key: :user_id
    belongs_to :group, ChattyApi.Chat.Group, foreign_key: :group_id
  end

  @doc false
  def changeset(%GroupUser{} = group_user, attrs) do
    group_user
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
  end
end
