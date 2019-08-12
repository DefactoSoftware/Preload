defmodule Job.Scopes do
  @moduledoc false
  def scope_on_preload(query, :employment, :actor, %{context: admin}) do
    {query, :employment, :actor, admin}
  end

  def scope_on_preload(query, :employment, :actor, options) do
    {query, :employment, :actor, options}
  end
end
