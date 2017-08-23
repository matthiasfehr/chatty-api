defmodule ChattyApi.Chat.GroupResolver do
  alias ChattyApi.{Chat.Group, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Group)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(Group, id) do
      nil -> {:error, "Group id #{id} not found"}
      group -> {:ok, group}
    end
  end

#  def create(args, _info) do
#    %Group{}
#    |> Group.changeset(args)
#    |> Repo.insert
#  end
end