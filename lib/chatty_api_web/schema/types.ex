defmodule ChattyApi.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: ChattyApi.Repo

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :friends, list_of(:user), resolve: assoc(:friends)
    field :groups, list_of(:group), resolve: assoc(:groups)
    field :messages, list_of(:message), resolve: assoc(:messages)
  end

  object :group do
    field :id, :id
    field :name, :string
    field :users, list_of(:user), resolve: assoc(:users)
    field :messages, list_of(:message), resolve: assoc(:messages)
  end

  object :message do
    field :id, :id
    field :text, :string
    field :user, :user, resolve: assoc(:user)
    field :group, :group, resolve: assoc(:group)
  end

#  input_object :message_input do
#    field :user_id, non_null(:id)
#    field :chat_room_id, non_null(:id)
#    field :body, non_null(:string)
#  end
end