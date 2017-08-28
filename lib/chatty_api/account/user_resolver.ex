defmodule ChattyApi.Account.UserResolver do
  alias ChattyApi.{Account.User, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end

  def find(user_query, _info) do
    case Repo.get_by(User, user_query) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    %User{}
    |> User.changeset(args)
    |> Repo.insert
  end
end