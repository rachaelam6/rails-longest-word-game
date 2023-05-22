class GamesController < ApplicationController
  require 'rest-client'

  def new
    alphabet = ('a'..'z').to_a
    @letters = []

  10.times do
    letter = alphabet.sample
    @letters << letter
  end
  end

  def score
    # Retrieve the word submitted by the player from the params hash.
    # Validate that every letter in the word appears in the grid of letters generated in the new action.
    # params[:word] represents the value submitted by the player for the word they found in the game.
    # params[:grid] represents the grid of letters generated in the new action and passed as a hidden field in the form.
    word = params[:word].strip.downcase
    grid = params[:grid].chars.map(&:downcase) # Assuming you pass the grid as a hidden field in the form

    # Validate that every letter in the word appears in the grid
    word_letters = word.chars
    return handle_invalid_word("The word can't be built out of the original grid.") unless word_letters.all? { |letter| grid.include?(letter) && word_letters.count(letter) <= grid.count(letter) }

    # Check if the word is a valid English word using the Wagon Dictionary API
    # Use the Wagon Dictionary API to check if the word is a valid English word.
    # Make a request to the API endpoint: "https://wagon-dictionary.herokuapp.com/#{word}".
    # Parse the API response to determine if the word is valid or not.
    response = JSON.parse(RestClient.get("https://wagon-dictionary.herokuapp.com/#{word}"))
    return handle_invalid_word("The word is not a valid English word.") unless response['found']

    # Calculate the score
    base_score = word.length
    time_taken = Time.now - Time.parse(params[:start_time]) # Assuming you pass the start_time as a hidden field in the form
    score = base_score - time_taken.to_i # You can modify the scoring system as per your requirements

    # Render the score.html.erb view and pass the score, word, and any error message as instance variables to display the result to the player.
    @score = score
    @word = word

    if score.zero?
      @error_message = "Sorry, you didn't score any points."
    else
      @success_message = "Congratulations! You scored #{score} points."
    end
  end

  def score_params
    params.require(:score).permit(:word, :grid, :start_time)
  end

  private

  def handle_invalid_word(message)
    @score = 0
    @word = params[:word]
    @error_message = message
    render :score
  end

end


# The params object in Ruby on Rails is a hash that contains all the parameters passed in a request.
# It allows you to access data sent from the client, such as form inputs, query parameters, or URL segments.

# The params hash is populated by Rails based on the incoming request.
# When you submit a form or make an HTTP request, the data is sent to the server, and Rails collects that data and makes it accessible through the params hash.

# The params hash uses symbols or strings as keys to access the values.
# The keys in the params hash typically correspond to the names or attributes of form inputs or other parameters sent in the request.

# For example, consider the following form input in an HTML form:

# <input type="text" name="username">
# If this form is submitted, the value entered in the input field can be accessed in the params hash using the key :username or 'username'. For instance:

# username = params[:username]
# # or
# username = params['username']

# Both params[:username] and params['username'] would retrieve the value of the username input field from the submitted form.

# In your case, params[:word] and params[:grid] are used to retrieve the values of the word and grid inputs from the submitted form data.
#   These values are then assigned to the variables word and grid for further processing in the scoring logic.

# Keep in mind that the keys in the params hash must match the names or attributes of the corresponding
# form inputs or request parameters in order to access their values correctly.
