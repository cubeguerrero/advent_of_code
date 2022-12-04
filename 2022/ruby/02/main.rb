f = File.open(File.join(File.dirname(__FILE__), 'input.txt'))

def compare(move1, move2)
  if move1 == move2
    0
  elsif move1 == 'rock'
    if move2 == 'paper'
      -1
    else
      1
    end
  elsif move1 == 'paper'
    if move2 == 'scissors'
      -1
    else
      1
    end
  elsif move2 == 'rock' # move1 is scissors
    -1
  else
    1
  end
end

def move_chooser(m1, what)
  return m1 if what == :draw

  if m1 == 'paper'
    if what == :win
      'scissors'
    else
      'rock'
    end
  elsif m1 == 'rock'
    if what == :win
      'paper'
    else
      'scissors'
    end
  elsif what == :win
    'rock'
  else
    'paper'
  end
end

total = 0

score_mapping = {
  'rock' => 1,
  'paper' => 2,
  'scissors' => 3
}

what_mapping = {
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
}

move1_mapping = {
  'A' => 'rock',
  'B' => 'paper',
  'C' => 'scissors'
}

move2_mapping = {
  'X' => 'rock',
  'Y' => 'paper',
  'Z' => 'scissors'
}

f.readlines.each do |line|
  m1, m2 = line.split(' ').map(&:strip)
  move1 = move1_mapping[m1]
  # move2 = move2_mapping[m2] # part 1
  move2 = move_chooser(move1, what_mapping[m2])
  cmp = compare(move1, move2)
  move_score = score_mapping[move2]

  game_score = if cmp == -1 # move2 won
                 6
               elsif cmp == 0
                 3
               else
                 0
               end

  total += move_score + game_score
end

puts total
