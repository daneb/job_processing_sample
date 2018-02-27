defmodule ImporterWeb.RunnerControllerTest do
  use ImporterWeb.ConnCase

  alias Importer.ImportRuns
  alias Importer.ImportRuns.Runner

  @create_attrs %{name: "some name", organization: "some organization"}
  @update_attrs %{name: "some updated name", organization: "some updated organization"}
  @invalid_attrs %{name: nil, organization: nil}

  def fixture(:runner) do
    {:ok, runner} = ImportRuns.create_runner(@create_attrs)
    runner
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all runner", %{conn: conn} do
      conn = get conn, runner_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create runner" do
    test "renders runner when data is valid", %{conn: conn} do
      conn = post conn, runner_path(conn, :create), runner: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, runner_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "organization" => "some organization"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, runner_path(conn, :create), runner: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update runner" do
    setup [:create_runner]

    test "renders runner when data is valid", %{conn: conn, runner: %Runner{id: id} = runner} do
      conn = put conn, runner_path(conn, :update, runner), runner: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, runner_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "organization" => "some updated organization"}
    end

    test "renders errors when data is invalid", %{conn: conn, runner: runner} do
      conn = put conn, runner_path(conn, :update, runner), runner: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete runner" do
    setup [:create_runner]

    test "deletes chosen runner", %{conn: conn, runner: runner} do
      conn = delete conn, runner_path(conn, :delete, runner)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, runner_path(conn, :show, runner)
      end
    end
  end

  defp create_runner(_) do
    runner = fixture(:runner)
    {:ok, runner: runner}
  end
end
