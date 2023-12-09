def get_diffs(pos, items)
  return [] if pos + 1 == items.length

  [items[pos+1] - items[pos]] + get_diffs(pos+1, items)
end

def get_next_in_sequence(items)
  last_items = []
  last_items << items.last
  current = items
  while current.uniq.length > 1 do
    current = get_diffs(0, current)
    last_items << current.last
  end
  last_items
end

def get_first_in_sequence(items)
  first_items = []
  first_items << items.first
  current = items
  while current.uniq.length > 1 do
    current = get_diffs(0, current)
    first_items << current.first
  end
  first_items
end

def part_one(input)
  input.reduce(0) do |acc, i|
    acc += get_next_in_sequence(i).sum
  end
end

def part_two(input)
  input.reduce(0) do |acc, i|
    first_items = get_first_in_sequence(i)
    acc += first_items.reverse.reduce(0) do |acc, item|
      item - acc
    end
  end
end

def parse_input(contents)
  contents.lines.map do |line|
    line.split(" ").map(&:to_i)
  end
end

def main
  contents = File.read("./input.txt")
  input = parse_input(contents)
  # p part_one(input)
  p part_two(input)
end

main
