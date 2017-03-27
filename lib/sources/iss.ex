defmodule Sources.ISS do
  @api "http://api.open-notify.org/iss-pass.json"

  defp convert_time(time) do
    Timex.from_unix(time)
    |> Timex.Timezone.convert(:utc)
    |> Timex.format!("{Mshort} {0D} {ISOtime}")
  end

  defp convert_duration(duration) do
    minutes = div(duration, 60)

    seconds = rem(duration, 60)
    |> Integer.to_string
    |> String.pad_leading(2, "0")

    "#{minutes}:#{seconds}"
  end

  def run(lat, lon) do
    HTTPoison.get!(@api <> "?lat=#{lat}&lon=#{lon}")
    |> Map.get(:body)
    |> Poison.decode!
    |> Map.get("response")
    |> Stream.map(fn(item) ->
      time = convert_time(item["risetime"])
      duration = convert_duration(item["duration"])
      "ISS: #{time}Duration: #{duration} min"
    end)
    |> Stream.with_index
    |> Stream.each(fn({title, index}) ->
      DAPNET.News.post "sat", (index + 1), title
    end)
    |> Stream.run
  end
end



