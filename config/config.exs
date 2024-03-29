# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :louvre,
  ecto_repos: [Louvre.Repo]

# Configures the endpoint
config :louvre, Louvre.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "35n/UmKtCVp8lMKMSyp4wExdVa1N+GSwrw3wTkk68wQSr6WwsCTHqjnoTGvXsQPg",
  render_errors: [view: Louvre.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Louvre.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Arc
config :arc,
  bucket: "louvre-test",
  virtual_host: true

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: "us-west-2",
  s3: [
    scheme: "https://",
    host: "s3-us-west-2.amazonaws.com",
    region: "us-west-2"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
