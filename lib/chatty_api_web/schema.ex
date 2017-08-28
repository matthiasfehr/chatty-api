defmodule ChattyApi.Schema do
  use Absinthe.Schema
  import_types ChattyApi.Schema.Types

  query do
    field :users, list_of(:user) do
      resolve &ChattyApi.Account.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, :id
      arg :email, :string
      arg :username, :string
      resolve &ChattyApi.Account.UserResolver.find/2
    end

    field :messages, list_of(:message) do
      arg :limit, :integer, default_value: 20
      arg :offset, :integer, default_value: 0
      resolve &ChattyApi.Chat.MessageResolver.all/2
    end

    field :groups, list_of(:group) do
      resolve &ChattyApi.Chat.GroupResolver.all/2
    end

    field :group, type: :group do
      arg :id, non_null(:id)
      resolve &ChattyApi.Chat.GroupResolver.find/2
    end
  end

  mutation do
    field :create_message, type: :message do
      #      arg :message_input, non_null(:message_input)
      arg :text, non_null(:string)
      arg :user_id, non_null(:integer)
      arg :group_id, non_null(:integer)

      resolve &ChattyApi.Chat.MessageResolver.create/2
    end

    field :create_group, type: :group do
      arg :name, non_null(:string)
      arg :user_id, :integer
      arg :user_ids, list_of(:integer)

      resolve &ChattyApi.Chat.GroupResolver.create/2
    end

    field :delete_group, type: :group do
      arg :id, non_null(:integer)

      resolve &ChattyApi.Chat.GroupResolver.delete/2
    end

    field :update_group, type: :group do
      arg :id, non_null(:integer)
      arg :name, non_null(:string)

      resolve &ChattyApi.Chat.GroupResolver.update/2
    end

    field :leave_group, type: :group do
      arg :id, non_null(:integer)
      arg :user_id, non_null(:integer)

      resolve &ChattyApi.Chat.GroupResolver.remove_user/2
    end

    #    createGroup(name: String!, userIds: [Int], userId: Int!): Group
    #    deleteGroup(id: Int!): Group
    #    leaveGroup(id: Int!, userId: Int!): Group # let user leave group
    #    updateGroup(id: Int!, name: String): Group

    #    field :create_group, type: :group do
    #      arg :title, non_null(:string)
    #      arg :user_id, non_null(:id)
    #
    #      resolve &ChattyApi.Chat.GroupResolver.create/2
    #    end
    #
    #    field :create_user, type: :user do
    #      arg :name, non_null(:string)
    #      arg :email, non_null(:string)
    #
    #      resolve &ChattyApi.Account.UserResolver.create/2
    #    end
  end

  subscription do
    field :message_added, :message do
      arg :group_id, non_null(:integer)

      topic fn args ->
        args.group_id
      end

      #      Trigger does not work when mutation is done over websocket, so it is commented out here
      #      trigger :create_message, topic: &(&1.group_id)

      #      Shorthand for:
      #      trigger :create_message, topic: fn message ->
      #        message.group_id
      #      end
    end

    field :group_added, :group do
      arg :user_id, non_null(:integer)

      topic fn args ->
        args.user_id
      end

      #      Trigger does not work when mutation is done over websocket, so it is commented out here
      #      trigger :create_message, topic: &(&1.group_id)

      #      Shorthand for:
      #      trigger :create_message, topic: fn message ->
      #        message.group_id
      #      end
    end
  end
end