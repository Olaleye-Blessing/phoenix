defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component
  alias __MODULE__.Component
  # use Phoenix.LiveComponent

  def hero(assigns) do
    ~H"""
    <h2>
    content: <%= @content %>
    </h2>
    """
  end
end
