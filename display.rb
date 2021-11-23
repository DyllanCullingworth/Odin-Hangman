module Display

  def display_banner
    puts "==================================================="
    puts "======================HANGMAN======================"
    puts "==================================================="
    puts ""
  end

  def display_available_letters
    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    @secret_word

    alphabet.each do |letter|
      print letter
      print ' '
    end
    puts "\n\n"
  end

  def display_letters
    @secret_word.split('').each do |letter|
      if @secret_letters[letter] == true
        print ' '
        print letter
      else
        print ' '
        print '_'
      end
    end
    puts "\n\n"
  end

  def display_info
    if @guesses_remaining == 1
      puts "Last chance!"
    else
      puts "#{@guesses_remaining} Guesses remaining"
    end
  end

  def clear
    print "\e[2J\e[H"
  end
end