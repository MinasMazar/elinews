defmodule ElinewsTest do
  use ExUnit.Case
  doctest Elinews

  @tag timeout: 120_000 # Override to infinity with `mix test --trace`

  test "Retrieve news with no arguments" do
    assert length(Elinews.retrieve_news) > 0
  end

  test "Retrive news with a filter" do
    assert length(Elinews.retrieve_news(title: 'trump')) > 0
  end
end
