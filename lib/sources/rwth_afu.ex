import SweetXml

defmodule Sources.RwthAfu do
  require Logger

  @url "https://www.afu.rwth-aachen.de/?format=feed&type=atom"

  def run do
    Logger.info "Running RWTH source"

    HTTPoison.get!(@url)
    |> Map.get(:body)
    |> xpath(~x"//entry/title/text()"sl)
    |> Stream.take(10)
    |> Stream.with_index
    |> Stream.each(fn({title, index}) ->
      DAPNET.News.post "rwth-afu", (index + 1), title
    end)
    |> Stream.run
  end
end
