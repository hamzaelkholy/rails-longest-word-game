require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def if_word_in_grid(attempt, grid)
    attempt.upcase.chars.all? do |letter|
      attempt.upcase.count(letter) <= grid.count(letter)
    end
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_tester = URI.open(url).read
    word_verification = JSON.parse(word_tester)

    if word_verification["found"] == false
      @display = "Sorry but #{@answer} does not seem to be a valid English word..."
    elsif if_word_in_grid(@answer, @letters)
      @display = "Sorry but #{@answer} can't be built out of #{@answer.join(',')}"
    else
      @display = 'Well done'
    end
  end

end
