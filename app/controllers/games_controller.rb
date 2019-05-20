class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    user_letters = params[:word].split('')
    if user_letters.all? { |letter| user_letters.count(letter) <= params[:choices].split.count(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
      json = JSON.parse(response.read)
      if json['found'] == false
        @results = "Sorry but #{params[:word]} is not an English word"
      else
        @results = "Congratulations #{params[:word]} is a valid English word"
      end
    else
      @impossible = "Sorry but #{params[:word]} can't be built out of these letters"
    end
  end
end
