defmodule CouchesWeb.PageController do
  use CouchesWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # Pass any necessary assigns here
    socket = conn.assigns

    render(conn, :home,  socket: socket)
  end


end
