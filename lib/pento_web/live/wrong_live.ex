defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(
      socket,
      score: 0,
      message: "Make a guess",
      name: "Anonymous",
      gender: "male",
      time: time()
      )
    }
  end

  def render(assigns) do
    ~H"""
    <p><a href="/">Home Page</a></p>
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    <div>
      <p>Player's name: <span><%= @name %></span></p>
      <button phx-click="name">Change name</button>
    </div>
    <div>
      <p>Player's genger: <span><%= @gender %></span></p>
      <!-- <button phx-click="gender">Switch Gender</button> -->
    </div>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}=data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time()
      )
    }
  end

  def handle_event("name", _data, socket) do
    current_name = socket.assigns.name
    new_name = if current_name == "Blessing" do
      "Yinka"
    else
      "Blessing"
    end

    {
      :noreply,
      assign(
        socket,
        name: new_name,
        time: time()
      )
    }
  end
end
