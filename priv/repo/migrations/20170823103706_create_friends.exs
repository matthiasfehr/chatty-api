defmodule ChattyApi.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :friend_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:friends, [:user_id])
    create index(:friends, [:friend_id])
    create index(:friends, [:user_id, :friend_id], unique: true)
  end
end
