def process_line(line)
  card, numbers = line.split(":")
  _, id = card.split(" ")
  w, p = numbers.split("|")
  winning_numbers = w.split(" ").map(&:to_i)
  player_numbers = p.split(" ").map(&:to_i)

  {
    id: id.to_i,
    winning_numbers: winning_numbers,
    player_numbers: player_numbers
  }
end

def process_input(contents)
  contents.lines.map { |line| process_line(line) }
end

def part_one(games)
  games.reduce(0) do |acc, game|
    w = game[:winning_numbers]
    p = game[:player_numbers]
    matched = p.select { |n| w.include? n }
    if matched.length > 0
      acc += 2 ** (matched.length - 1)
    else
      acc
    end
  end
end

def part_two(games)
  card_counter = [1] * (games.length + 1)
  card_counter[0] = 0

  games.each do |game|
    card_num = game[:id]
    number_of_current_cards = card_counter[card_num]

    w = game[:winning_numbers]
    p = game[:player_numbers]
    matched = p.select { |n| w.include? n }
    start = card_num + 1
    final = card_num + matched.length

    (start..final).each do |n|
      card_counter[n] = card_counter[n] + number_of_current_cards
    end
  end

  card_counter.sum
end

def main
  contents = File.read("./input.txt")
  games = process_input(contents)
  puts "The answer for part 1 is #{part_one(games)}"
  puts "The answer for part 2 is #{part_two(games)}"
end

main
