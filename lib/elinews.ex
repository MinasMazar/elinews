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

  def run(criteria) do
    retrieve_news(criteria)
    |> display()
  end

  @doc """
  iex> Elinews.retrieve_news(title: "trump") |> length() > 0
  true

  iex> Elinews.retrieve_news([title: "trump", title: "eijrijer"], :union) |> length() > 0
  true

  iex(1)> default_arg = Elinews.retrieve_news(title: "trump", title: "eijrijer")
  iex(1)> explicit_x = Elinews.retrieve_news([title: "trump", title: "eijrijer"], :x)
  iex(1)> default_arg == explicit_x
  true
  """

  def retrieve_news(criteria, mode \\ :x) do
    retrieve_news()
    |> filter(criteria, mode)
  end

  @doc """
  iex> Elinews.retrieve_news |> length() > 0
  true
  """

  defmemo retrieve_news do
    Enum.map(news_feeds(), fn (url) ->
      HTTPotion.get(url, follow_redirects: true).body
      |> Floki.find("item")
      |> Enum.map(&item_map(&1))
    end) |> List.flatten
  end

  def retrieve_news! do
    Memoize.invalidate(Elinews)
    retrieve_news()
  end

  def retrieve_news!(criteria) do
    Memoize.invalidate(Elinews)
    retrieve_news(criteria)
  end

  def filter(items, criteria, mode) when is_list(criteria) do
    {acc, func} = case mode do
                    :union -> {false, &Kernel.or/2}
                    :x -> {true, &Kernel.and/2}
                  end
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
