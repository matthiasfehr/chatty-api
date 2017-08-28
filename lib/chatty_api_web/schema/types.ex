defmodule ChattyApi.Schema.Types do
  import Ecto.Query
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: ChattyApi.Repo
  import_types Absinthe.Type.Custom

  object :user do
    field :id, :integer
    field :username, :string
    field :email, :string
    field :friends, list_of(:user), resolve: assoc(:friends)
    field :groups, list_of(:group), resolve: assoc(:groups)
    field :messages, list_of(:message), resolve: assoc(:messages)
  end

  object :group do
    field :id, :integer
    field :name, :string
    field :users, list_of(:user), resolve: assoc(:users)
    field :messages, list_of(:message), resolve: assoc(:messages, fn query, _, _ ->
      query |> order_by(desc: :inserted_at)
    end)
  end

  object :message do
    field :id, :integer
    field :text, :string
    field :inserted_at, :naive_datetime
    field :from, :user, resolve: assoc(:user)
    field :to, :group, resolve: assoc(:group)
  end

#  input_object :message_input do
#    field :user_id, non_null(:id)
#    field :chat_room_id, non_null(:id)
#    field :body, non_null(:string)
#  end
end