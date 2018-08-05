ExUnit.start()

defmodule Elinews.Mocks.Display do
  def puts(_str) do
  end
end

defmodule Elinews.Mocks.HttpClient do
  def get(url, _options) do
    Elinews.HttpClient.get(url, follow_redirects: true)
  end
end
