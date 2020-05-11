defmodule AppWeb.PageLiveTest do
  use AppWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to the app."
    assert render(page_live) =~ "Welcome to the app."
  end
end
