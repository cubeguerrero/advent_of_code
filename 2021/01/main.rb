file = File.open('input.txt')

numbers = []
file.each_line do |line|
  numbers << line.strip.to_i
end

increase_count = 0
previous = numbers[0]
(1...numbers.length).each do |n|
  current = numbers[n]
  if current > previous
    increase_count += 1
  end

  previous = current
end

puts increase_count # part 1

increase_count = 0
previous = numbers[0] + numbers[1] + numbers[2]
(1..(numbers.length - 3)).each do |n|
  current = numbers[n] + numbers[n+1] + numbers[n+2]
  if current > previous
    increase_count += 1
  end
  previous = current
end

puts increase_count
