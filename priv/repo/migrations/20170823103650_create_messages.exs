defmodule ChattyApi.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :group_id, references(:groups, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:group_id])
  end
end
