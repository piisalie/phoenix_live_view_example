defmodule DemoWeb.UserView do
  use DemoWeb, :view
  import Phoenix.LiveView
  alias DemoWeb.UserLive

  def table(do: block) do
    content_tag(:tbody, phx_update: "append", id: "users") do
      block
    end
  end

  def render_user(user) do
    content_tag(:tr, class: "user-row", phx_hook: "Row", id: "user-#{user.id}") do
      [
        content_tag(:td, user.username),
        content_tag(:td, user.email)
      ]
    end
  end
end
