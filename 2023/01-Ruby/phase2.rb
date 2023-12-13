def main
  if ARGV.length < 1
    puts "Usage: #{$PROGRAM_NAME} filename"
  end

  solve
end

def solve
  first = last = -1
  sum = 0
  numDict = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
  }

  File.open(ARGV[0]) do |file|
    file.each do |str|
      #puts "#{str}"
      str.split(//).each_with_index do |letter, index|
        numDict.each do |k, v|
          if str[index..].start_with?(k) then
            last = v
            first = last if first == -1
          end
        end
        if letter.match?(/\d/) then
          last = letter.to_i
          first = last if first == -1
        end
      end
      first *= 10
      sum += first + last
      first = last = -1
    end
    puts "sum: #{sum}"
  end
end

main
