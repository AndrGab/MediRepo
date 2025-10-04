defmodule Medirepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :medirepo,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "test.watch": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Medirepo.Application, []},
      extra_applications: [:logger, :runtime_tools, :bamboo]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.21"},
      {:phoenix_ecto, "~> 4.6"},
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.1"},
      {:gettext, "~> 0.25"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.7"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:pbkdf2_elixir, "~> 2.1"},
      {:guardian, "~> 2.4"},
      {:secure_random, "~> 0.5"},
      {:bamboo, "~> 2.2"},
      {:bamboo_smtp, "~> 4.1"},
      {:excoveralls, "~> 0.18", only: :test},
      {:cors_plug, "~> 3.0"},
      {:ex_machina, "~> 2.8", only: :test},
      {:absinthe, "~> 1.7.10"},
      {:absinthe_plug, "~> 1.5.9"},
      {:faker, "~> 0.18", only: :test},
      {:mix_test_watch, "~> 1.3", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
