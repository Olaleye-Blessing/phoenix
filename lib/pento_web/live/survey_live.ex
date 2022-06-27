defmodule PentoWeb.SurveyLive do
  use Phoenix.LiveView
  alias Pento.Survey
  alias PentoWeb.DemographicLive

  # alias Pento.Accounts
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end
end
