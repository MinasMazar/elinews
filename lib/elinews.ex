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

  def run do
    run([])
  end

  def run(criteria) do
    retrieve_news(criteria)
    |> display()
  end

  @doc """
  iex> Elinews.retrieve_news(title: "trump") |> length() > 0
  true

  iex> Elinews.retrieve_news(title: "trump", title: "eijrijer") |> length() > 0
  true

  iex> Elinews.retrieve_news([title: "trump", title: "eijrijer"]) |> length() > 0
  true
  """

  def retrieve_news(criteria) do
    retrieve_news()
    |> filter(criteria, :x)
  end

  @doc """
  iex> Elinews.retrieve_news |> length() > 0
  true
  """

  def retrieve_news do
    HTTPotion.get(@news_feed, follow_redirects: true).body
    |> Floki.find("item")
    |> Enum.map(&item_map(&1))
  end

  # defp filter(items, criteria) when is_map(criteria) do
  #   criteria
  #   |> Enum.map(fn(c) -> filter(items, c) end)
  #   |> Enum.reduce([], fn(item,acc) -> [acc | item] end)
  # end

  def filter(items, criteria, mode \\ :union) when is_list(criteria) do
    Enum.map(criteria, fn ({field, value}) ->
      Enum.filter(items, fn (item) ->
        {:ok, content} = Map.fetch(item, field)
        Regex.run(~r/#{value}/i, content)
      end)
    end)
    |> Enum.reduce([], (fn (item, acc) -> [acc | item] end))
    # |> (fn (items) ->
    #   IO.puts(length(items))
    # end).()
  end

  def display(news_entries) when is_list(news_entries) do
    news_entries |> Enum.map(&display(&1))
  end

  def display(news_entry) do
    news_entry_displayed = """
    News entry: #{news_entry.title}
    """
    IO.puts(news_entry_displayed)
  end

  defmodule NewsEntry do
    defstruct [:title, :description, :link]
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
end
