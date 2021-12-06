module GameLogic

  def play
    @game_over = false

    load_game?

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
    if @game_over
      return
    end

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
    puts "Play again? Y/N"
    
    if gets.chomp.downcase == 'y'
      hangman = Hangman.new
      hangman.play
    else
      puts "Thanks for playing!"
      return
    end
  end

  def make_a_guess(text)
    puts text + " or type save to save your game." 
    guess = gets.chomp.downcase

    if guess == 'save'
      save_game
      game_over!("Game saved succesfully")
      return
    end

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

  def save_game
    dirname = 'saved_games'
    Dir.mkdir(dirname) unless File.exists? dirname

    puts 'Enter a name for your save.'
    save_name = gets.chomp.downcase + '.json'
    save_file = "#{dirname}/#{save_name}"

    if File.exists? save_file
      puts "That file already exists, please use a different name."
      save_game
      return
    else
      file = File.open(save_file, 'w')

      file.puts self.serialize

      file.close
    end
  end

  def load_game?
    puts 'Would you like to load a saved game? Y/N'

    if gets.chomp.downcase == 'y'
      load_game
    end
  end

  def load_game
    clear
    dirname = 'saved_games'
    Dir.mkdir(dirname) unless File.exists? dirname

    save_files = Dir.glob "#{dirname}/*.json"

    puts

    save_files.each do |file|
      puts file.gsub("#{dirname}/", "").chomp(".json")
    end
    
    puts "Please enter the name of the file you want to load"
    load_name = gets.chomp.downcase
    file_name = "#{dirname}/#{load_name}.json"

    if File.exists? file_name
      file = File.open(file_name, 'r')

      self.unserialize file.read
    else
      puts "Please choose a valid saved game"
      load_game
      return
    end
  end
end