defmodule Feed do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Feed.Scheduler, [])
    ]

    opts = [strategy: :one_for_one, name: Feed.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
