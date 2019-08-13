defmodule Preload.MixProject do
  use Mix.Project

  def project do
    [
      app: :preload,
      name: "Preload",
      version: "0.1.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: true,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    A module to dynamically preload based on schema files.
    """
  end

  defp package do
    [
      name: :preload,
      maintainers: ["Marcel Horlings"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/defactosoftware/preload"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false}
    ]
  end
end
