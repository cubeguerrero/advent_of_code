SourceDestinationMap = Struct.new(:type, :source_range, :destination_range)

def get_seeds_from_input(input)
  _, numbers = input.split(":")
  numbers.split(" ").map do |n|
    n.strip.to_i
  end
end

def get_map_from_input(input)
  type, values = input.split(":")
  type, _ = type.split(" ")
  [type, values.strip.split("\n").map do |line|
    destination, source, offset = line.split(" ").map(&:to_i)
    source_range = source...(source+offset)
    destination_range = destination...(destination+offset)
    SourceDestinationMap.new(type, source_range, destination_range)
  end]
end

def parse_input(input)
  input = input.split("\n\n")
  seeds = get_seeds_from_input(input[0])
  maps = input[1..].map do |input|
    get_map_from_input(input)
  end.to_h
  [seeds, maps]
end

def get_destination(source, map)
  val = map.reduce(-1) do |acc, m|
    if m.source_range.min <= source && source < m.source_range.max
      pos = source - m.source_range.min
      m.destination_range.min + pos
    else
      acc
    end
  end

  if val == -1
    source
  else
    val
  end
end

def solution(seeds, maps)
  seeds.map do |seed|
    puts "Seed: #{seed}"
    ["seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water", "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"].reduce(seed) do |acc, type|
      get_destination(acc, maps[type])
    end
  end.min
end

def get_seeds_for_part_two(seeds)
  seeds.each_slice(2).map do |r|
    (r[0]...(r[0] + r[1]))
  end
end

def main
  input = File.read("./input.txt")
  seeds, maps = parse_input(input)
  # p solution(seeds, maps)
  p get_seeds_for_part_two(seeds).map { |seed_range| solution(seed_range, maps) }.min

  # p solution(, maps)
end

main
