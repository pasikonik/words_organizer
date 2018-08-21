defmodule WordsOrganizer.Mixfile do
  use Mix.Project

  def application do
    [applications: [:benchfella]]
  end

  def project do
    [app: :words_organizer, version: "1.0.0", deps: deps()]
  end

  defp deps do
    [{:benchfella, "~> 0.3.5"}]
  end
end
