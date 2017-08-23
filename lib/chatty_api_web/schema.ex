defmodule ChattyApi.Schema do
  use Absinthe.Schema
  import_types ChattyApi.Schema.Types
  import_types Absinthe.Type.Custom

  query do
    field :users, list_of(:user) do
      resolve &ChattyApi.Account.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &ChattyApi.Account.UserResolver.find/2
    end

    field :messages, list_of(:message) do
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
#
#  mutation do
#    field :create_message, type: :message do
#      arg :message_input, non_null(:message_input)
#
#      resolve &ChattyApi.Chat.MessageResolver.create/2
#    end
#
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
#  end
#
#  subscription do
#    field :message_added, :message do
#      arg :group_id, non_null(:id)
#
#      topic &(String.to_integer(&1.group_id))
#
#      #      This is the shorthand function for this:
#      #      topic fn args ->
#      #        String.to_integer(args.group_id)
#      #      end
#
#      #      Trigger does not work when mutation is done over websocket, so it is commented out here
#      #      trigger :create_message, topic: &(&1.group_id)
#
#      #      Shorthand for:
#      #      trigger :create_message, topic: fn message ->
#      #        message.group_id
#      #      end
#    end
#  end
end