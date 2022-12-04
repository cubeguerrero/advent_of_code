require 'set'

LETTERS = ('a'..'z').to_a + ('A'..'Z').to_a

class Rucksack
  attr_reader :items

  def initialize(input)
    @items = Set.new(input.split(''))
  end

  def intersection(rucksack)
    @items.intersection(rucksack.items)
  end
end

def get_score(letter)
  LETTERS.index(letter) + 1
end

# Part 1
# def main
#   input = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
#   total = 0

#   input.readlines.each_with_index do |line, _index|
#     line_length = line.length
#     mid = line_length / 2
#     rucksack1 = Rucksack.new(line[0...mid])
#     rucksack2 = Rucksack.new(line[mid..-1])
#     intersection = rucksack1.intersection(rucksack2)
#     total += get_score(intersection.first)
#   end

#   puts "Total: #{total}"
# end

# Part 2
def main
  input = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
  total = 0

  current = []
  input.readlines.each do |line|
    current << line

    next unless current.length == 3

    rucksacks = current.map do |inner_line|
      Set.new(inner_line.strip.split(''))
    end
    letter = rucksacks[0].intersection(rucksacks[1]).intersection(rucksacks[2]).first
    total += get_score(letter)
    current = []
  end

  puts "Total: #{total}"
end

main
