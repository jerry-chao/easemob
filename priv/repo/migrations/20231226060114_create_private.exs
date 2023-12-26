defmodule Easemob.Repo.Migrations.CreatePrivate do
  use Ecto.Migration

  def change do
    create table(:private) do
      add :from, :string
      add :to, :string
      add :message, :string

      timestamps()
    end
  end
end
