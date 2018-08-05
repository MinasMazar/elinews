defmodule Elinews.HttpClient do
  @moduledoc """
  adapter: HttpClient module
  """

  def get(url, _options) do
    HTTPotion.get(url, follow_redirects: true)
  end
end
