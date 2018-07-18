defmodule ElinewsTest do
  use ExUnit.Case
  doctest Elinews

  test "greets the world" do
    assert Elinews.hello() == :world
  end
end
