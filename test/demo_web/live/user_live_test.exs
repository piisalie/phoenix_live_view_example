defmodule DemoWeb.UserLive.IndexManualScrollTest do
  use DemoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "can test appended data", %{conn: conn} do
    for x <- 1..100 do
      Demo.Accounts.create_user(%{
        username: "user-#{x}",
        email: "user-#{x}@example.com",
        phone_number: "+1 204-239-2394",
        password: "#{x}",
        password_confirmation: "#{x}"
      })
    end

    {:ok, view, _html} = live(conn, "/users-scroll")

    render_submit(view, "load-more", %{})
    render_submit(view, "load-more", %{})
    result = render(view)

    assert result
  end
end
