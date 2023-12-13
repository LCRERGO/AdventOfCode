def main
  if ARGV.length < 1
    puts "Usage: #{$PROGRAM_NAME} filename"
  end

  solve
end

def solve
  first = last = -1
  sum = 0

  File.open(ARGV[0]) do |file|
    file.each do |str|
      #puts "#{str}"
      for letter in str.split(//) do
                      if letter.match?(/\d/) then
                        last = letter.to_i
                        first = last if first == -1
                      end
                    end
        first *= 10
        #puts "(#{first},#{last}): #{first + last}"
        sum += first + last
        first = last = -1
      end
      puts "sum: #{sum}"
    end
  end

  main
