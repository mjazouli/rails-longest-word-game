require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |lettre|
      lettre = ('A'..'Z').to_a.sample
      @letters << lettre
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:result]}"
    check_alphabet = URI.open(url).read
    @check = JSON.parse(check_alphabet)

    @p_result = params[:result].upcase.chars
    @p_letters = params[:letters].split

    if @check['found'] == false
      @resultat = "#{@p_result.join} is not an english word"
    elsif @check['found'] && @p_result.all? { |letter| @p_result.count(letter) <= @p_letters.count(letter) }
      @resultat = "Congratulation  #{@p_result.join} is an english word in #{@p_letters}"
    else
      @resultat = "sorry but #{@p_result.join} is not in #{@p_letters}"
    end
  end
end
