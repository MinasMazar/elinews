require IEx

defmodule NewsEntry do
  defstruct [:title, :time, :description, :link, :rest]

  def sort(entries) do
    Enum.sort(entries, fn(a,b) ->
      case NaiveDateTime.compare a.time, b.time do
        :lt -> false
        :gt -> true
        _ -> true
      end
    end)
  end

  def parse(item) do
    {"item", [], [
        {"title", [], [title]},
        {"description", [], [description]},
        {"link", [], [link]},
        {"pubdate", [], [date]}
        | rest
      ]
    } = item
    %NewsEntry{title: title, time: parse_time(date), description: description, link: link, rest: rest}
  end

  def parse_time(time_str) do
    [_ | [day, month, year, hour, min, sec]] = Regex.run ~r[(\d+) (\w+) (\d+) (\d+):(\d+):(\d+)], time_str
    [year, day, hour, min, sec] = Enum.map([year, day, hour, min, sec], fn(s) ->
      {i, _} = Integer.parse s
      i
    end)
    date = NaiveDateTime.new year, parse_month(month), day, hour, min, sec
    case date do
      {:ok, data} -> data
      {:error, } -> nil
      _ -> nil
    end
  end

  def parse_month(month_str) do
    [
      Jan: 1,
      Feb: 2,
      Mar: 3,
      Apr: 4,
      May: 5,
      Jun: 6,
      Jul: 7,
      Aug: 8,
      Sep: 9,
      Oct: 10,
      Nov: 11,
      Dev: 12
    ][String.to_atom(month_str)]
  end
end
