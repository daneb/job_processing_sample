defmodule Importer.ImportRuns.Runner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Importer.ImportRuns.Runner


  schema "runner" do
    field :name, :string
    field :organization, :string

    timestamps()
  end

  @doc false
  def changeset(%Runner{} = runner, attrs) do
    runner
    |> cast(attrs, [:name, :organization])
    |> validate_required([:name, :organization])
  end
end
