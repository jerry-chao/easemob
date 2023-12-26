import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :easemob, Easemob.Repo,
  username: "root",
  password: "123456",
  hostname: "mysql",
  database: "easemob_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :easemob, EasemobWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "A1ZdDMuDk1NwbyGnMOLlGwGekgttzRSsIK2Ao0vrYHa8ObGzCnnoZMgNMAGS5z8e",
  server: false

# In test we don't send emails.
config :easemob, Easemob.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
