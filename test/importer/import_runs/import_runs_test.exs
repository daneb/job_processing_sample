defmodule Importer.ImportRunsTest do
  use Importer.DataCase

  alias Importer.ImportRuns

  describe "runner" do
    alias Importer.ImportRuns.Runner

    @valid_attrs %{name: "some name", organization: "some organization"}
    @update_attrs %{name: "some updated name", organization: "some updated organization"}
    @invalid_attrs %{name: nil, organization: nil}

    def runner_fixture(attrs \\ %{}) do
      {:ok, runner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ImportRuns.create_runner()

      runner
    end

    test "list_runner/0 returns all runner" do
      runner = runner_fixture()
      assert ImportRuns.list_runner() == [runner]
    end

    test "get_runner!/1 returns the runner with given id" do
      runner = runner_fixture()
      assert ImportRuns.get_runner!(runner.id) == runner
    end

    test "create_runner/1 with valid data creates a runner" do
      assert {:ok, %Runner{} = runner} = ImportRuns.create_runner(@valid_attrs)
      assert runner.name == "some name"
      assert runner.organization == "some organization"
    end

    test "create_runner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ImportRuns.create_runner(@invalid_attrs)
    end

    test "update_runner/2 with valid data updates the runner" do
      runner = runner_fixture()
      assert {:ok, runner} = ImportRuns.update_runner(runner, @update_attrs)
      assert %Runner{} = runner
      assert runner.name == "some updated name"
      assert runner.organization == "some updated organization"
    end

    test "update_runner/2 with invalid data returns error changeset" do
      runner = runner_fixture()
      assert {:error, %Ecto.Changeset{}} = ImportRuns.update_runner(runner, @invalid_attrs)
      assert runner == ImportRuns.get_runner!(runner.id)
    end

    test "delete_runner/1 deletes the runner" do
      runner = runner_fixture()
      assert {:ok, %Runner{}} = ImportRuns.delete_runner(runner)
      assert_raise Ecto.NoResultsError, fn -> ImportRuns.get_runner!(runner.id) end
    end

    test "change_runner/1 returns a runner changeset" do
      runner = runner_fixture()
      assert %Ecto.Changeset{} = ImportRuns.change_runner(runner)
    end
  end
end
