use Mix.Config

config :elinews, adapters: %{
  display: Elinews.Display,
  http_client: Elinews.HttpClient
}
