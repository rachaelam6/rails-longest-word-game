Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#new"

  get "new", to: "games#new"
  post "score", to: "games#score"

end


# These lines define routes in your Ruby on Rails application.
# Routes map URLs to controller actions, allowing you to handle HTTP requests and
# specify which controller and action should be invoked for a particular URL.

# get "new", to: "games#new": This line defines a GET route that maps the URL /new to the new action in the GamesController.
# When a user visits /new, the new action in the GamesController will be executed.
# Typically, this route is used to display a form or initial view to start a new game.

# post "score", to: "games#score": This line defines a POST route that maps the URL /score to the score action in the GamesController.
# When a user submits a form or makes a POST request to /score, the score action in the GamesController will be executed.
# This route is responsible for handling the form submission, processing the player's input, and calculating the score.

# By defining these routes, you specify the mapping between URLs and controller actions,
# allowing your application to handle different types of requests and perform the appropriate actions.

# Routes are an essential part of the Rails routing system
