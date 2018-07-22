require IEx
defmodule Elinews do
  @moduledoc """
  Documentation for Elinews.
  """
  @news_feed "http://www.tgcom24.mediaset.it/rss/ultimissime.xml"

  @doc """
  Retrieve news feed XML file and extract news informations.

  ## Examples

  iex> Elinews.news_feed
  "http://www.tgcom24.mediaset.it/rss/ultimissime.xml"

  """

  defmodule NewsEntry do
    defstruct [:title, :description, :link]
  end

  def news_feed do
    @news_feed
  end

  @doc """
  iex> Elinews.retrieve_news |> length() > 0
  true
  """

  def retrieve_news(criteria) do
    {field, keyword} = hd criteria
    retrieve_news()
    |> filter(field, keyword)
  end

  @doc """
  iex> Elinews.retrieve_news(title: "trump") |> length() > 0
  true
  """

  def retrieve_news do
    HTTPotion.get(@news_feed, follow_redirects: true).body
    |> Floki.find("item")
    |> Enum.map(&item_map(&1))
  end

  defp item_map(item) do
    {"item", [], [
        {"title", [], title},
        {"description", [], [description]},
        {"link", [], [link]}
        | _
      ]
    } = item
    %NewsEntry{title: hd(title), description: description, link: link}
  end

  defp filter(items, field, value) do
    items
    |> Enum.filter(fn(i) ->
      {:ok, value} = Map.fetch(i, field)
      Regex.run(~r/#{value}/i, value)
    end)
  end
end
