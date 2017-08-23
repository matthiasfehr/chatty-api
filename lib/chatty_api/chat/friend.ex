defmodule ChattyApi.Chat.Friend do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.Friend


  schema "friends" do
    belongs_to :user, ChattyApi.Account.User
    belongs_to :friend, ChattyApi.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Friend{} = friend, attrs) do
    friend
    |> cast(attrs, [])
    |> validate_required([])
  end
end
