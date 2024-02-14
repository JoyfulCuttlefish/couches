defmodule Couches.ResultTest do
  use Couches.DataCase

  alias Couches.Result

  describe "jobs" do
    alias Couches.Result.Job

    import Couches.ResultFixtures

    @invalid_attrs %{name: nil}

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Result.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Result.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Job{} = job} = Result.create_job(valid_attrs)
      assert job.name == "some name"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Job{} = job} = Result.update_job(job, update_attrs)
      assert job.name == "some updated name"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_job(job, @invalid_attrs)
      assert job == Result.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Result.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Result.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Result.change_job(job)
    end
  end
end
