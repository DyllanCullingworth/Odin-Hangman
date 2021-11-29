module GameLogic

  def play
    @game_over = false

    until @game_over
      clear
      display_banner
      display_available_letters
      display_letters
      display_info

      make_a_guess("Make a guess")
      @guesses_remaining -= 1

      game_over?
      sleep(1)
    end
  end

  def game_over?
    unless @secret_letters.values.include? false
      game_over!('Winner')
    end

    if @guesses_remaining == 0
      game_over!('Out of moves')
    end  
  end

  def game_over!(text)
    @game_over = true
    puts text
    play_again?
  end

  def play_again?
    return
  end

  def make_a_guess(text)
    puts text 
    guess = gets.chomp.downcase

    if valid_guess? guess
      @guesses << guess

      if @secret_letters.has_key? guess
        puts "Brilliant guess"
        @secret_letters[guess] = true
      else
        puts "Incorrect guess"
      end
    end 
  end

  def valid_guess?(guess)
    if guess.match /^[a-z]$/
      if @guesses.include? guess
        puts 
        make_a_guess("You have already chosen that letter\n Try again")
      else 
       return true
      end
    else
      puts 
      make_a_guess("Invalid guess\n Try again")
    end
    
    false
  end 
end