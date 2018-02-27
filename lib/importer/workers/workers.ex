defmodule Importer.Workers do
  def perform() do
    response = HTTPotion.get "http://archive.ics.uci.edu/ml/machine-learning-databases/00196/ConfLongDemo_JSI.txt"
    IO.puts("Status of Big Data Fetch #{HTTPotion.Response.success?(response)}")
  end
end