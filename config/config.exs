# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :importer,
  ecto_repos: [Importer.Repo]

# Configures the endpoint
config :importer, ImporterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WwBm4KYM3lRVBqmEyIDh24sYsJYOXUdNRQxxSVGV8VnAMWXeytPaNNeo/uAdDqpN",
  render_errors: [view: ImporterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Importer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: 500,
  queues: ["bigdata"],
  scheduler_enable: true

config :exq_ui,
  server: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
