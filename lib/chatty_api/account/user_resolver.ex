defmodule ChattyApi.Account.UserResolver do
  alias ChattyApi.{Account.User, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    %User{}
    |> User.changeset(args)
    |> Repo.insert
  end
end