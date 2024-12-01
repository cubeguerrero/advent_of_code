input = File.read('./input.txt')

first_list = []
second_list = []
second_freq = Hash.new(0)

input.each_line do |line|
  a, b = line.split(' ')

  first_list << a.to_i
  second_list << b.to_i
  second_freq[b.to_i] += 1
end

sorted_first_list = first_list.sort
second_list.sort!

part1 = sorted_first_list.map.with_index do |item, index|
  (item - second_list[index]).abs
end

puts part1.sum

puts second_freq

part2 = first_list.map do |item|
  item * second_freq[item]
end

puts part2.sum
