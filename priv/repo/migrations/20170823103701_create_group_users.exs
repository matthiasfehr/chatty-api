defmodule ChattyApi.Repo.Migrations.CreateGroupUsers do
  use Ecto.Migration

  def change do
    create table(:group_users) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :group_id, references(:groups, on_delete: :delete_all), null: false
    end

    create index(:group_users, [:user_id])
    create index(:group_users, [:group_id])
    create index(:group_users, [:user_id, :group_id], unique: true)
  end
end
