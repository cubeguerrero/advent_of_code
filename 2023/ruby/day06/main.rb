def parse_input(input)
  time, distance = input.split("\n")
  _, time  = time.split(":")
  time = time.split(" ").map(&:to_i)
  _, distance = distance.split(":")
  distance = distance.split(" ").map(&:to_i)

  time.zip(distance)
end

def _solution_part_one(min, max, max_time, goal)
  mid = (min + max) / 2
  return [] if mid == min || mid == max

  if (max_time - mid) * mid > goal
    _solution_part_one(min, mid, max_time, goal) + [mid] + _solution_part_one(mid, max, max_time, goal)
  else
    _solution_part_one(min, mid, max_time, goal) + _solution_part_one(mid, max, max_time, goal)
  end
end

def get_num_of_ways(input)
  time, distance = input
  _solution_part_one(0, time, time, distance)
end

def part_one(input)
  input.reduce(1) do |acc, i|
    acc * get_num_of_ways(i).length
  end
end

def fix_input_for_part_two(input)
  input.reduce(["", ""]) do |acc, input|
    ["#{acc[0]}#{input[0]}", "#{acc[1]}#{input[1]}"]
  end.map(&:to_i)
end

def part_two(input)
end

def main
  contents = File.read("./input.txt")
  input = parse_input(contents)
  # p part_one(input)
  p get_num_of_ways(fix_input_for_part_two(input)).length
end

main
