Game = Struct.new(:id, :turns)
Turn = Struct.new(:count, :color)

def parse_turns(turns_input)
  turns_input.split(";").map do |turn|
    turn.split(",").map do |t|
      t.strip!
      count, color = t.split(" ")
      Turn.new(count.to_i, color)
    end
  end
end

def parse_line_to_game(line)
  game, turns = line.split(":")
  id = game.split(" ").last.to_i
  turns = parse_turns(turns)

  Game.new(id, turns)
end

# Part 1: Start
def parse_input(input)
  input.lines.map { |l| parse_line_to_game(l) }
end

def check_if_turn_is_valid(turn, config)
  turn.all? do |t|
    t.count <= config[t.color.to_sym]
  end
end

def check_if_game_is_valid(game, config)
  game.turns.all? { |t| check_if_turn_is_valid(t, config) }
end

def part_one(games)
  config = {
    red: 12,
    green: 13,
    blue: 14
  }
  games.inject(0) do |acc, game|
    if check_if_game_is_valid(game, config)
      acc + game.id
    else
      acc
    end
  end
end
# Part 1: End
def find_minimum_config(game)
  base_config = {
    red: 0,
    green: 0,
    blue: 0
  }
  game.turns.inject(base_config) do |acc, turn|
    turn.each do |t|
      if t.count > acc[t.color.to_sym]
        acc[t.color.to_sym] = t.count
      end
    end

    acc
  end
end

def part_two(games)
  games.inject(0) do |acc, game|
    minimum_config = find_minimum_config(game)
    acc + minimum_config.values.reduce(:*)
  end
end

def main
  contents = File.read("./input.txt")
  games = parse_input(contents)
  # p part_one(games)
  p part_two(games)
end

main
