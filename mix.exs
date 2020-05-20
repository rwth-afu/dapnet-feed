defmodule DapnetFeed.Mixfile do
  use Mix.Project

  def project do
    [app: :dapnet_feed,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      mod: {Feed, []},
      applications: [:timex, :quantum],
      extra_applications: [:logger]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 1.6.2"},
      {:poison, "~> 4.0.1"},
      {:quantum, "~> 2.4.0"},
      {:timex, "~> 3.6.1"},
      {:sweet_xml, "~> 0.6.5"}
    ]
  end
end
