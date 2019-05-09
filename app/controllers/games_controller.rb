require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = ('A'..'Z').to_a.sample(10)
    @answer = params[:answer] = 'answer'

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    @english = user['found']

    params[:word].split('').all? do |letter|
      if @letters.include?(letter) == true && @english == true
        @answer = "Great Job!"
      elsif @english == false
        @answer = "This is not an english word"
      elsif @letters.include?(letter) == false
        @answer = "Use the given letters only!"
      end
    end
  end
end
