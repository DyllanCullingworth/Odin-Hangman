class Hangman
  attr_accessor :guesses

  def initialize
    @guesses = 0

    @random_word = random_word
  end

  def test
    @random_word.split('')
  end

  private

  def random_word
    file = File.open('dictionary.txt', 'r')
    arr = file.readlines
    file.close

    arr[rand(arr.size-1)].chomp
  end
end


hangman = Hangman.new
p hangman.test