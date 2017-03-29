import SweetXml

defmodule Sources.METAR do
  @api "https://aviationweather.gov/adds/dataserver_current/httpparam"
  @params "dataSource=metars&requestType=retrieve&format=xml&hoursBeforeNow=2&mostRecentForEachStation=true"

  def run(rubric, icao_list) do
    stations = Enum.join(icao_list, ",")

    HTTPoison.get!(@api <> "?" <> @params <> "&stationString=" <> stations)
    |> Map.get(:body)
    |> xpath(~x"//METAR/raw_text/text()"sl)
    |> Enum.sort_by(fn(item) ->
      Enum.find_index(icao_list, fn(icao) ->
        icao == String.slice(item, 0, 4)
      end)
    end)
    |> Enum.with_index
    |> Enum.each(fn({title, index}) ->
      DAPNET.News.post rubric, (index + 1), title
    end)
  end
end
