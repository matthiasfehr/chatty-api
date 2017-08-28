defmodule ChattyApi.Chat.GroupResolver do
  alias ChattyApi.{Chat.Group, Chat.Message, Repo, Account.User}
  import Ecto.Query

  def all(_args, _info) do
    {:ok, Repo.all(Group)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Group, id) do
      nil -> {:error, "Group id #{id} not found"}
      group -> {:ok, group}
    end
  end

  def create(args, _info) do
    user_query = from u in User, where: u.id == ^args.user_id
    friends = Repo.all(
      from u in user_query,
      join: f in assoc(u, :friends),
      where: f.id in ^args.user_ids,
      select: f
    )
    user = Repo.get(User, args.user_id)
    group_members = List.insert_at(friends, -1, user)
    with {:ok, %Group{} = group} <- %Group{}
                         |> Group.changeset(args)
                         |> Ecto.Changeset.put_assoc(:users, group_members)
                         |> Repo.insert do
      Absinthe.Subscription.publish(ChattyApiWeb.Endpoint, group, list(friends, user))
      {:ok, group}
    end

    defp list(friends, user) do
      {_, acc} = Enum.map_reduce(
        friends,
        [group_added: user.id],
        fn (user, acc) -> {[group_added: user.id], Enum.concat(acc, [group_added: user.id])} end
      )
      acc
    end

    def delete(args, _info) do
      group = Repo.get(Group, args.id)
      deleted_group = delete_group(group)
      {:ok, deleted_group}
    end

    def update(args, _info) do
      Repo.get(Group, args.id)
      |> Group.changeset(args)
      |> Repo.update()
    end

    def remove_user(args, _info) do
      group = Repo.get(Group, args.id)
              |> Repo.preload(:users)
      new_group_members = Enum.reject(group.users, fn (u) -> u.id == args.user_id end)
      case length(new_group_members) do
        0 ->
          delete_group(group)
        _ ->
          Ecto.Changeset.change(group)
          |> Ecto.Changeset.put_assoc(:users, new_group_members)
          |> Repo.update
      end
    end

    defp delete_group(group) do
      Repo.delete_all(from m in Message, where: m.group_id == ^group.id)
      Repo.delete!(group)
    end
  end