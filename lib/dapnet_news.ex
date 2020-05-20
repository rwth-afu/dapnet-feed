defmodule DAPNET.News do
  @headers [{"Content-Type", "application/json"}]

  def endpoint do
    "http://" <> Application.get_env(:dapnet_feed, :server) <> "/rubrics"
  end

  def auth do
    auth = Application.get_env(:dapnet_feed, :auth)
    user = auth[:user]
    pass = auth[:pass]
    [hackney: [basic_auth: {user, pass}]]
  end

  def post(rubric, number, text) do
    path = endpoint() <> "/#{rubric}/news/#{number}"

    item = %{
      data: text
    }

    result = HTTPoison.put!(path, Poison.encode!(item), @headers, auth())
    IO.inspect(result)
  end
end
