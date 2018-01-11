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
    if Application.get_env(:dapnet_feed, :testing) do
      IO.inspect item
    else
      HTTPoison.post!(endpoint(), Poison.encode!(item), @headers, auth())
    end
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
