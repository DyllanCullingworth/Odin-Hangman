module CleanDictionary
  # takes raw_dictionary and produces a new one containing only valid words

  def clean
    raw_dictionary = File.open('raw_dictionary.txt', 'r')
    dictionary = File.open('dictionary.txt', 'w')

    while !raw_dictionary.eof?
      line = raw_dictionary.readline.chomp
      if line.length <= 12 && line.length >=5
        dictionary.puts line.downcase
      end
    end

    raw_dictionary.close
    dictionary.close
  end
end