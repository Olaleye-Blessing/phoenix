defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  @max_random 40

  def mount(_params, _session, socket) do
    {:ok, assign(
      socket,
      score: 0,
      message: "Make a guess between 0 and #{@max_random}(inclusive)",
      name: "Anonymous",
      gender: "male",
      time: time(),
      random_num: :rand.uniform(@max_random + 1),
      max_random: @max_random,
      guessed_right: true
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
      <%= for n <- 1..@max_random do %>
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
    <div>
      <%= if @guessed_right do %>
        <button phx-click="restart">Restart</button>
      <% end %>
    </div>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("restart", _data, socket) do
    IO.puts "Restarting"

    # fix this with live_patch
    { :noreply,
      assign(
        socket,
      score: 0,
      message: "Make a guess between 0 and #{@max_random}(inclusive)",
      name: "Anonymous",
      gender: "male",
      time: time(),
      random_num: :rand.uniform(@max_random + 1),
      max_random: @max_random,
      guessed_right: true
      )
    }
  end

  def handle_event("guess", data, socket) do
    %{"number" => guess} = data
    %{random_num: secret_number, score: current_score} = socket.assigns

    guess = String.to_integer(guess)

    {message, score} = cond do
      guess == secret_number -> {"You guessed right", current_score + 1}
      guess > secret_number -> {"You guess is greater than secret number", current_score - 1}
      guess < secret_number -> {"You guess is less than secret number", current_score - 1}
    end

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
