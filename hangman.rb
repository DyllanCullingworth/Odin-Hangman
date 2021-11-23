require "./display"
require "./game_logic"
require './serialize'


class Hangman
  attr_accessor :guess_count, :guesses, :secret_word, :secret_letters

  include Display
  include GameLogic
  include Serialize
  
  def initialize()
    @guesses_remaining = 6
    @guesses = []

    @secret_word = random_word
    @secret_letters = letters_hash(@secret_word)
  end

  def letters_hash(word)
    hash = Hash.new 0

    word.split('').each do |value|
      hash["#{value}"] = false
    end

    hash
  end

  private

  def random_word
    file = File.open('dictionary.txt', 'r')
    arr = file.readlines
    file.close

    arr[rand(arr.size-1)].chomp
  end
end