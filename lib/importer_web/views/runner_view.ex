defmodule ImporterWeb.RunnerView do
  use ImporterWeb, :view
  alias ImporterWeb.RunnerView

  def render("index.json", %{runner: runner}) do
    %{data: render_many(runner, RunnerView, "runner.json")}
  end

  def render("show.json", %{runner: runner}) do
    %{data: render_one(runner, RunnerView, "runner.json")}
  end

  def render("runner.json", %{runner: runner}) do
    %{id: runner.id,
      name: runner.name,
      organization: runner.organization}
  end
end
