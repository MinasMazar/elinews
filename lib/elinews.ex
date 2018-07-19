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

  def news_feed do
    @news_feed
  end

  def retrieve_news(criteria) do
    {field, keyword} = hd criteria
    retrieve_news()
    |> filter(field, keyword)
  end

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
    %{title: hd(title), description: description, link: link}
  end

  defp filter(items, field, value) do
    items
    |> Enum.filter(fn(i) -> Regex.run(~r/#{value}/i, i[field]) end)
  end
end
