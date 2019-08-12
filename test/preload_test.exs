defmodule PreloadTest do
  use ExUnit.Case

  test "reach the scope_on_preload of the job schema " do
    assert {Job, :employment, :actor, %{}} ==
             Job
             |> Preload.scope(:employment, :actor)
  end

  test "add options to the preload" do
    assert {Job, :employment, :actor, :admin} ==
             Job
             |> Preload.scope(:employment, :actor, %{context: :admin})
  end
end
