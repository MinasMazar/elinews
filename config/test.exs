use Mix.Config

config :elinews, adapters: %{
  display: Elinews.Mocks.Display,
  http_client: Elinews.Mocks.HttpClient
}
