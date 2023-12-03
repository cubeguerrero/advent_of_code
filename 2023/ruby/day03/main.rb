Value = Struct.new(:value, :start, :end)
Point = Struct.new(:x, :y)

def compare_point(point1, point2)
  point1.x == point2.x && point1.y == point2.y
end

def parse_line(line, y)
  stack = []
  numbers = []
  symbols = []
  line.strip!
  line.chars.each_with_index do |c, x|
    if c == "."
      # check if stack has something
      if stack.length > 0
        current = []
        end_x = x - 1
        start_x = x - stack.length
        while stack.length > 0
          current.unshift stack.pop
        end

        numbers << Value.new(
          current.join("").to_i,
          Point.new(start_x, y),
          Point.new(end_x, y)
        )
      end
    elsif c.match("[[:digit:]]")
      stack << c
    else
      symbols << Value.new(
        c,
        Point.new(x, y),
        Point.new(x, y)
      )
      if stack.length > 0
        current = []
        end_x = x - 1
        start_x = x - stack.length
        while stack.length > 0
          current.unshift stack.pop
        end

        numbers << Value.new(
          current.join("").to_i,
          Point.new(start_x, y),
          Point.new(end_x, y)
        )
      end
    end
  end

  if stack.length > 0
    current = []
    end_x = line.length - 1
    start_x = line.length - stack.length
    while stack.length > 0
      current.unshift stack.pop
    end

    numbers << Value.new(
      current.join("").to_i,
      Point.new(start_x, y),
      Point.new(end_x, y)
    )
  end

  [numbers, symbols]
end

def parse_input(contents)
  numbers = []
  symbols = []
  contents.lines.each_with_index do |line, index|
    n, s = parse_line(line, index)
    numbers += n
    symbols += s
  end

  [numbers, symbols]
end

def get_adjacent_points(point)
  [
    Point.new(point.x-1, point.y-1),
    Point.new(point.x, point.y-1),
    Point.new(point.x+1,point.y-1),
    Point.new(point.x-1, point.y),
    Point.new(point.x+1,point.y),
    Point.new(point.x-1, point.y+1),
    Point.new(point.x, point.y+1),
    Point.new(point.x+1,point.y+1)
  ]
end

def part_one(numbers, symbols)
  matched_numbers = []
  symbols.each do |s|
    get_adjacent_points(s.start).each do |point|
      matched_numbers += numbers.filter do |number|
        compare_point(number.start, point) || compare_point(number.end, point)
      end
    end
  end
  matched_numbers.uniq!
  matched_numbers.reduce(0) { |acc, n| acc + n.value }
end

def part_two(numbers, symbols)
  total = 0
  symbols.filter { |symbol| symbol.value == "*" }.each do |s|
    matched = []
    get_adjacent_points(s.start).each do |point|
      matched += numbers.filter do |number|
        compare_point(number.start, point) || compare_point(number.end, point)
      end
    end

    matched.uniq!
    if matched.length == 2
      total += matched[0].value * matched[1].value
    end
  end

  total
end

def main
  contents = File.read("./input.txt")
  numbers, symbols = parse_input(contents)
  # answer = part_one(numbers, symbols)
  answer = part_two(numbers, symbols)
  puts "The answer is #{answer}"
end

main
