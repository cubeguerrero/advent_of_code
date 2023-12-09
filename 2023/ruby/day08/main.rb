def get_moves(moves)
  moves.strip!
  moves.split("")
end

def get_nodes(nodes)

  h = Hash.new { [] }
  nodes.lines do |line|
    line.strip!
    value, connections = line.split("=")
    left, right = connections.split(",")
    left.strip!
    right.strip!
    h[value.strip] = [left[1..], right[..-2]]
  end

  h
end

def parse_input(contents)
  moves, nodes = contents.split("\n\n")

  [get_moves(moves), get_nodes(nodes)]
end

def part_one(moves, graph)
  found = false
  counter = 0
  l = moves.length
  pos = 0
  current = "AAA"

  while !found do
    move = moves[pos % l]
    m = if move == "L"
      0
    else
      1
    end

    counter += 1
    pos += 1
    current = graph[current][m]

    if current == "ZZZ"
      found = true
      break
    end
  end

  counter
end

def part_two(moves, graph)
  found = false
  counter = 0
  l = moves.length
  pos = 0
  starting = graph.keys.select { |k| k.end_with? "A" }

  starting.map do |key|
    found = false
    counter = 0
    l = moves.length
    pos = 0
    current = key

    while !found do
      move = moves[pos % l]
      m = if move == "L"
        0
      else
        1
      end

      counter += 1
      pos += 1
      current = graph[current][m]

      if current.end_with? "Z"
        found = true
      end
    end

    counter
  end.reduce(1, :lcm)
end

def main
  contents = File.read("./input.txt")
  moves, graph = parse_input(contents)
  # p part_one(moves, graph)
  p part_two(moves, graph)
end

main
