defmodule Importer.Repo.Migrations.CreateRunner do
  use Ecto.Migration

  def change do
    create table(:runner) do
      add :name, :string
      add :organization, :string

      timestamps()
    end

  end
end
