defmodule DemoWeb.UserLive.IndexManualScroll do
  use Phoenix.LiveView

  import DemoWeb.UserView, only: [render_user: 1, table: 1]

  def render(assigns) do
    ~L"""
    <table style="visibility: hidden;">
      <%= table do %>
        <%= for user <- @users do %>
          <%= render_user(user) %>
        <% end %>
      <% end %>
    <form phx-submit="load-more">
      <button phx-disable-with="loading...">more</button>
    </form>
    """
  end

  def mount(_session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10, val: 0)
     |> fetch(), temporary_assigns: [:users]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, users: Demo.Accounts.list_users(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
