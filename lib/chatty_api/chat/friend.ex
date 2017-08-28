defmodule ChattyApi.Chat.Friend do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.Friend


  schema "friends" do
    belongs_to :user, ChattyApi.Account.User
    belongs_to :friend, ChattyApi.Account.User
  end

  @doc false
  def changeset(%Friend{} = friend, attrs) do
    friend
    |> cast(attrs, [:user_id, :friend_id])
    |> validate_required([:user_id, :friend_id])
  end
end
