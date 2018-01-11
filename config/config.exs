# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :dapnet_feed, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:dapnet_feed, :key)
#
# Or configure a 3rd-party app:
#

config :logger, level: :info

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#

import_config "local.exs"

config :dapnet_feed, Feed.Scheduler,
  jobs: [
    {"30 * * * *", {Sources.RwthAfu, :run, []}},
    {:iss, [
      schedule: "15 */2 * * *",
      task: {Sources.ISS, :run, ["50.77", "6.08"]}
    ]},
    {:metar_dl_nw, [
      schedule: "21,51 * * * *",
      task: {Sources.METAR, :run, [
        "metar-dl-nw",
        ["EDDK", "EDDL", "EDDG", "ETNG", "EDLW", "EDLP"]
      ]}
    ]},
    {:metar_dl_rp, [
      schedule: "22,52 * * * *",
      task: {Sources.METAR, :run, [
        "metar-dl-rp",
        ["EDFH", "EDRZ"]
      ]},
    ]},
    {:metar_dl_ns, [
      schedule: "23,53 * * * *",
      task: {Sources.METAR, :run, [
        "metar-dl-ni",
        ["EDDV", "EDVE", "ETMN"]
      ]}
    ]},
    {:metar_dl_bw, [
      schedule: "24,54 * * * *",
      task: {Sources.METAR, :run, [
        "metar-dl-bw",
        ["EDDS", "EDSB", "EDNY", "EDTL"]
      ]}
    ]}
  ]
