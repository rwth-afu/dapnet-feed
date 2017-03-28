defmodule DAPNET.News do
  @headers [{"Content-Type", "application/json"}]

  def endpoint do
    "http://" <> Application.get_env(:dapnet_feed, :server) <> "/news"
  end

  def auth do
    auth = Application.get_env(:dapnet_feed, :auth)
    user = auth[:user]
    pass = auth[:pass]
    [hackney: [basic_auth: {user, pass}]]
  end

  def post(item) do
    HTTPoison.post!(endpoint(), Poison.encode!(item), @headers, auth())
  end

  def post(rubric, text) do
    post %{
      text: text,
      rubricName: rubric
    }
  end

  def post(rubric, number, text) do
    post %{
      text: text,
      rubricName: rubric,
      number: number
    }
  end
end
