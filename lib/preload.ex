defmodule Preload do
  @moduledoc """
  To use Preload scopes add a file named `<Your.Schema>` where Your.Schema should
  be the module of the schema you're trying to preload on.
  Next to that add a file with the module `<Your.Schema>.Scopes`
  in this module you can add `scope_on_preload/4` functions.

  ## Example

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
  """

  @doc """
  The scope accepts queries with preloads as an atom or a list of atoms.
  It will resolve the main schema of the query and apply the scope_on_preload
  function on that schema.

  ## Example
      iex> Job
      ...> |> Preload.scope([:managers, :employees], user, options)
      ...> |> Repo.get!(id)
      %Job{managers: [%User{} | _], employees: [%User{} | _]}
  """
  def scope(query, preloads, user, options \\ %{})

  def scope(query, [], _, _), do: query

  def scope(query, [preload], user, options), do: scope_on_preload(query, preload, user, options)

  def scope(query, [preload | rest], user, options),
    do:
      query
      |> scope(preload, user, options)
      |> scope(rest, user, options)

  def scope(query, preload, user, options), do: scope_on_preload(query, preload, user, options)

  defp scope_on_preload(query, preload, user, options) do
    query
    |> resolve_schema()
    |> Module.concat(Scopes)
    |> apply(:scope_on_preload, [query, preload, user, options])
  end

  defp resolve_schema(%{__struct__: Ecto.Query, from: %{source: {_source, schema}}})
       when is_atom(schema) and not is_nil(schema),
       do: schema

  # List of structs
  defp resolve_schema([%{__struct__: schema} | _rest]), do: schema

  # Schema module itself
  defp resolve_schema(schema) when is_atom(schema), do: schema

  # Unable to determine
  defp resolve_schema(unknown) do
    raise ArgumentError, "Cannot automatically determine the schema of
      #{inspect(unknown)} - specify the :schema option"
  end
end
