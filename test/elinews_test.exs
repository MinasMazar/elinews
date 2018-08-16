defmodule ElinewsTest do
  use ExUnit.Case
  doctest Elinews

  # @tag timeout: 120_000 # Override to infinity with `mix test --trace`
  @tag :driver
  test "Driver test (reusable)" do
    Elinews.run(title: "terremoto", title: "molise")
  end
end
