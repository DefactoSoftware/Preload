# Preload

## Installation

```elixir
def deps do
  [
    {:preload, "~> 0.1.0"}
  ]
end
```

## Usage

To use Preload scopes add a file named `<Your.Schema>` where Your.Schema should
be the module of the schema you're trying to preload on.
Next to that add a file with the module `<Your.Schema>.Scopes`
in this module you can add `scope_on_preload/4` functions.

Example:

```ex
defmodule App.Jobs.Enrollment do
  def some_fun(actor, %{preload: preload)) do
    Job
    |> where(active: true)
    |> Preload.scope(preload, actor)
  end
end

defmodule App.Jobs.Enrollment.Scopes do
  def scope_on_preload(query, preloads, user, options) do
    #...
  end
end
```
