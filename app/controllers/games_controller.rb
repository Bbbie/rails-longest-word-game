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
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    json['found']
  end
end
