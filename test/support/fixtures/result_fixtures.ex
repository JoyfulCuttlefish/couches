defmodule Couches.ResultFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Couches.Result` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(attrs \\ %{}) do
    {:ok, job} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Couches.Result.create_job()

    job
  end
end
