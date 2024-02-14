defmodule CouchesWeb.JobLive.Index do
  use CouchesWeb, :live_view

  alias Couches.Result
  alias Couches.Result.Job

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :jobs, Result.list_jobs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Job")
    |> assign(:job, Result.get_job!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Job")
    |> assign(:job, %Job{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Jobs")
    |> assign(:job, nil)
  end

  @impl true
  def handle_info({CouchesWeb.JobLive.FormComponent, {:saved, job}}, socket) do
    {:noreply, stream_insert(socket, :jobs, job)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    job = Result.get_job!(id)
    {:ok, _} = Result.delete_job(job)

    {:noreply, stream_delete(socket, :jobs, job)}
  end
end
