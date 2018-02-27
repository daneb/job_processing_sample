defmodule ImporterWeb.RunnerController do
  use ImporterWeb, :controller

  alias Importer.ImportRuns
  alias Importer.ImportRuns.Runner

  action_fallback ImporterWeb.FallbackController

  def index(conn, _params) do
    runner = ImportRuns.list_runner()

    # Normal Queueing
    # Exq.enqueue(Exq, "bigdata", Importer.Workers, [])

    # Scheduled Queueing
    Exq.enqueue_in(Exq, "bigdata", 3600, Importer.Workers, [])

    render(conn, "index.json", runner: runner)
  end

  def create(conn, %{"runner" => runner_params}) do
    with {:ok, %Runner{} = runner} <- ImportRuns.create_runner(runner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", runner_path(conn, :show, runner))
      |> render("show.json", runner: runner)
    end
  end

  def show(conn, %{"id" => id}) do
    runner = ImportRuns.get_runner!(id)
    render(conn, "show.json", runner: runner)
  end

  def update(conn, %{"id" => id, "runner" => runner_params}) do
    runner = ImportRuns.get_runner!(id)

    with {:ok, %Runner{} = runner} <- ImportRuns.update_runner(runner, runner_params) do
      render(conn, "show.json", runner: runner)
    end
  end

  def delete(conn, %{"id" => id}) do
    runner = ImportRuns.get_runner!(id)
    with {:ok, %Runner{}} <- ImportRuns.delete_runner(runner) do
      send_resp(conn, :no_content, "")
    end
  end
end
