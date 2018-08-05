# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :elinews, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:elinews, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
    import_config "#{Mix.env}.exs"

config :elinews, news_feeds: [
  "http://www.ansa.it/sito/notizie/topnews/topnews_rss.xml",
  "http://www.ansa.it/sito/ansait_rss.xml",
  "http://www.ansa.it/sito/notizie/cronaca/cronaca_rss.xml",
  "http://www.ansa.it/sito/notizie/politica/politica_rss.xml",
  "http://www.ansa.it/sito/notizie/mondo/mondo_rss.xml",
  "http://www.ansa.it/sito/notizie/economia/economia_rss.xml",
  "http://www.ansa.it/sito/notizie/sport/calcio/calcio_rss.xml",
  "http://www.ansa.it/sito/notizie/sport/sport_rss.xml",
  "http://www.ansa.it/sito/notizie/cultura/cinema/cinema_rss.xml",
  "http://www.ansa.it/sito/notizie/cultura/cultura_rss.xml",
  "http://www.ansa.it/sito/notizie/tecnologia/tecnologia_rss.xml",
  "http://www.ansa.it/abruzzo/notizie/abruzzo_rss.xml",
  "http://www.ansa.it/basilicata/notizie/basilicata_rss.xml",
  "http://www.ansa.it/calabria/notizie/calabria_rss.xml",
  "http://www.ansa.it/campania/notizie/campania_rss.xml",
  "http://www.ansa.it/emiliaromagna/notizie/emiliaromagna_rss.xml",
  "http://www.ansa.it/friuliveneziagiulia/notizie/friuliveneziagiulia_rss.xml",
  "http://www.ansa.it/lazio/notizie/lazio_rss.xml",
  "http://www.ansa.it/liguria/notizie/liguria_rss.xml",
  "http://www.ansa.it/lombardia/notizie/lombardia_rss.xml",
  "http://www.ansa.it/marche/notizie/marche_rss.xml",
  "http://www.ansa.it/molise/notizie/molise_rss.xml",
  "http://www.ansa.it/piemonte/notizie/piemonte_rss.xml",
  "http://www.ansa.it/puglia/notizie/puglia_rss.xml",
  "http://www.ansa.it/sardegna/notizie/sardegna_rss.xml",
  "http://www.ansa.it/sicilia/notizie/sicilia_rss.xml",
  "http://www.ansa.it/toscana/notizie/toscana_rss.xml",
  "http://www.ansa.it/trentino/notizie/trentino_rss.xml",
  "http://www.ansa.it/umbria/notizie/umbria_rss.xml",
  "http://www.ansa.it/valledaosta/notizie/valledaosta_rss.xml",
  "http://www.ansa.it/veneto/notizie/veneto_rss.xml",
]
