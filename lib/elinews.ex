require NewsEntry
require IEx

defmodule Elinews do
  use Memoize

  @moduledoc """
  Documentation for Elinews.
  """
  @news_feeds ["http://www.tgcom24.mediaset.it/rss/ultimissime.xml"]

  @doc """
  Retrieve news feed XML file and extract news informations.

  ## Examples

  iex> Elinews.news_feeds |> length() > 0
  true

  """
  @adapters Application.get_env(:elinews, :adapters)

  def news_feeds do
    feeds = Application.get_env(:elinews, :news_feeds)
    case length(feeds) > 0 do
      true -> feeds
      false -> @news_feeds
    end
  end

  def run do
    run([])
  end

  def run(criteria, mode \\ :x) do
    retrieve_news()
    |> NewsEntry.sort
    |> filter(criteria, mode)
    # |> display
  end

  @doc """
  iex> Elinews.run(title: "trump") |> length() > 0
  true

  iex> Elinews.run([title: "trump", title: "eijrijer"], :union) |> length() > 0
  true

  iex(1)> default_arg = Elinews.run(title: "trump", title: "eijrijer")
  iex(1)> explicit_x = Elinews.run([title: "trump", title: "eijrijer"], :x)
  iex(1)> default_arg == explicit_x
  true
  """

  defmemo retrieve_news do
    Enum.map(news_feeds(), fn (url) ->
      @adapters.http_client.get(url, follow_redirects: true).body
      |> Floki.find("item")
      |> Enum.map(&(NewsEntry.parse(&1)))
    end) |> List.flatten
  end

  def reset_news_cache! do
    Memoize.invalidate(Elinews)
  end

  def filter(items, criteria, mode) when is_list(criteria) do
    {acc, func} = filter_reduction_for_mode(mode)
    Enum.filter(items, fn (item) ->
      Enum.map(criteria, fn ({field, value}) ->
        {:ok, content} = Map.fetch(item, field)
        !!Regex.run(~r/#{value}/i, content)
      end)
      |> Enum.reduce(acc, fn (result, acc) ->
        apply(func, [result, acc])
      end)
    end)
  end

  def display(news_entries) when is_list(news_entries) do
    news_entries |> Enum.map(&display(&1))
  end

  def display(news_entry) do
    news_entry_displayed = """
    ## #{news_entry.title}
    #
    # #{news_entry.description}
    #

    """
    @adapters.display.puts news_entry_displayed
  end

  defp filter_reduction_for_mode(mode) do
    case mode do
      :union -> {false, &Kernel.or/2}
      :x -> {true, &Kernel.and/2}
    end
  end
end
