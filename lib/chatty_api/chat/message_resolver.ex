defmodule ChattyApi.Chat.MessageResolver do
  alias ChattyApi.{Chat.Message, Repo}
  import Ecto.Query

  def all(args, _info) do
    messages = Message |> limit(^args.limit) |> offset(^args.offset) |> Repo.all
    {:ok, messages}
  end

  def create(args, _info) do
#    message_args = elem(args, 0)
#    with {:ok, %Message{} = message} <- ChattyApi.Chat.create_message(message_args) do
##     Publish to subscriptions manually (since trigger in schema doesn't work for websocket mutations)
#      Absinthe.Subscription.publish(ChattyApiWeb.Endpoint, message, [message_added: message.chat_room_id])
#      {:ok, message}
#    end
    with {:ok, %Message{} = message} <- ChattyApi.Chat.create_message(args) do
      Absinthe.Subscription.publish(ChattyApiWeb.Endpoint, message, [message_added: message.group_id])
      {:ok, message}
    end
  end
end