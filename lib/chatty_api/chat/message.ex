defmodule ChattyApi.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChattyApi.Chat.Message


  schema "messages" do
    field :text, :string
    belongs_to :user, ChattyApi.Account.User, foreign_key: :user_id
    belongs_to :group, ChattyApi.Chat.Group, foreign_key: :group_id

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:text, :user_id, :group_id])
    |> validate_required([:text, :user_id, :group_id])
  end
end
