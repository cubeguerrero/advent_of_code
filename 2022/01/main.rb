f = File.open(File.join(File.dirname(__FILE__), 'input.txt'))

calories = []
current = 0

f.readlines.each do |line|
  line = line.strip
  if line == ''
    calories << current
    current = 0
  else
    current += line.to_i
  end
end

calories.sort!
puts calories[-3..-1].sum
