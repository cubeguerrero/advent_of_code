def get_numbers_in_line(line)
  word_to_num_map = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }
  nums = []
  line.length.times do |pos|
    if line[pos].match?(/[[:digit:]]/)
      nums << line[pos].to_i
      next
    end

    ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"].each do |num|
      if line[pos..(pos + num.length - 1)] == num
        nums << word_to_num_map[num]
        break
      end
    end
  end

  nums[0] * 10 + nums[-1]
end

def part_two(input)
  input.lines.map { |line| get_numbers_in_line(line) }.sum
end

def part_one(input)
  input.lines.map do |line|
    numbers = line.tr('^0-9','')
    "#{numbers[0]}#{numbers[-1]}".to_i
  end.sum
end

def main
  contents = File.read("./input.txt")
  # puts part_one(contents)
  puts part_two(contents)
end

main
