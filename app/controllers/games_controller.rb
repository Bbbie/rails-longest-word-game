require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    #  get a random letter from the alphabet 9 times
    @letters = 9.times.map { ('A'..'Z').to_a.sample }
    # @letters = 9.times.map { ('A'..'Z').to_a[rand(26)] }
    # @letters = (0..9).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:answer].split(//)
    @grid = params[:letters]
    @english_word = check_english(@answer)
    check(@answer) if @english_word
  end

  private

  def check_english(word)
    # check, if answer is an actual english word in open-uri
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    raw_json = open(url).read
    json_hash = JSON.parse(raw_json)
    json_hash["found"]
  end

  def check(answer, letters)
    letters.each do |letter|
      if grid.include? letter
        grid.gsub(letter, "")
      else
        return
      end
    end
  end
end
