use Mix.Config

config :firestorm_web, FirestormWeb.Web.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Start notification server in app start
config :firestorm_web, notifications_enabled: false

# Configure your database
config :firestorm_web, FirestormWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "firestorm_web_test",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :firestorm_web, :aws,
  access_key_id: "access_key_id",
  secret_access_key: "secret_access_key",
  bucket: "bucket",
  region: "region"

config :firestorm_web, sql_sandbox: true

config :firestorm_web, FirestormWeb.Mailer,
  adapter: Bamboo.TestAdapter

config :bamboo, :refute_timeout, 10

config :wallaby, screenshot_on_failure: true, phantomjs: "/firestorm-node_modules/phantomjs-prebuilt/bin/phantomjs"

config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
