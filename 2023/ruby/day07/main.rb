# mapping for part one
# CARD_VALUE_MAPPING = {
#   "2" => 1,
#   "3" => 2,
#   "4" => 3,
#   "5" => 4,
#   "6" => 5,
#   "7" => 6,
#   "8" => 7,
#   "9" => 8,
#   "T" => 9,
#   "J" => 10,
#   "Q" => 11,
#   "K" => 12,
#   "A" => 13
# }

# mapping for part two
CARD_VALUE_MAPPING = {
  "J" => 1,
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "7" => 7,
  "8" => 8,
  "9" => 9,
  "T" => 10,
  "Q" => 11,
  "K" => 12,
  "A" => 13
}



FIVE_OF_A_KIND = :five_of_a_kind
FOUR_OF_A_KIND = :four_of_a_kind
FULL_HOUSE = :full_house
THREE_OF_A_KIND = :three_of_a_kind
TWO_PAIR = :two_pair
ONE_PAIR = :one_pair
HIGH_CARD = :high_card

HAND_TYPE_VALUE_MAPPING = {
  HIGH_CARD => 0,
  ONE_PAIR => 1,
  TWO_PAIR => 2,
  THREE_OF_A_KIND => 3,
  FULL_HOUSE => 4,
  FOUR_OF_A_KIND => 5,
  FIVE_OF_A_KIND => 6
}

Card = Struct.new(:value) do
  def compare(other_card)
    CARD_VALUE_MAPPING[self.value] <=> CARD_VALUE_MAPPING[other_card.value]
  end
end

Hand = Struct.new(:cards, :type) do
  def compare(other_hand)
    cmp = HAND_TYPE_VALUE_MAPPING[self.type] <=> HAND_TYPE_VALUE_MAPPING[other_hand.type]
    if cmp == 0
      comparisons = self.cards.zip(other_hand.cards).map do |(a, b)|
        a.compare(b)
      end

      i = 0
      while comparisons[i] == 0 do
        i += 1
      end
      comparisons[i]
    else
      cmp
    end
  end

  def to_s
    self.cards.map(&:value).join("")
  end
end

def find_type_for_hand_part_one(cards)
  freq = Hash.new(0)
  cards.each do |card|
    freq[card.value] += 1
  end

  keys_length = freq.keys.length
  vals = freq.values.sort
  if keys_length == 1
    FIVE_OF_A_KIND
  elsif keys_length == 2
    if vals == [1, 4]
      FOUR_OF_A_KIND
    else
      FULL_HOUSE
    end
  elsif keys_length == 3
    if vals == [1, 1, 3]
      THREE_OF_A_KIND
    else
      TWO_PAIR
    end
  elsif keys_length == 4
    ONE_PAIR
  else
    HIGH_CARD
  end
end

def find_type_for_hand_part_two(cards)
  freq = Hash.new(0)
  cards.each do |card|
    freq[card.value] += 1
  end


  keys_length = freq.keys.length
  vals = freq.values.sort
  joker_count = freq["J"]
  has_joker = joker_count > 0
  if keys_length == 1
    FIVE_OF_A_KIND
  elsif keys_length == 2
    if vals == [1, 4]
      if has_joker
        FIVE_OF_A_KIND
      else
        FOUR_OF_A_KIND
      end
    else
      if has_joker
        FIVE_OF_A_KIND
      else
        FULL_HOUSE
      end
    end
  elsif keys_length == 3
    if vals == [1, 1, 3]
      if has_joker
        if joker_count == 2
          FIVE_OF_A_KIND
        else
          FOUR_OF_A_KIND
        end
      else
        THREE_OF_A_KIND
      end
    else
      if has_joker
        if joker_count == 2
          FOUR_OF_A_KIND
        else
          FULL_HOUSE
        end
      else
        TWO_PAIR
      end
    end
  elsif keys_length == 4
    if has_joker
      THREE_OF_A_KIND
    else
      ONE_PAIR
    end
  else
    if has_joker
      ONE_PAIR
    else
      HIGH_CARD
    end
  end
end

def parse_input_part_one(input)
  input.lines.map do |line|
    line.strip!
    cards, value = line.split(" ")
    cards = cards.each_char.map { |ch| Card.new(ch) }
    hand = Hand.new(cards, find_type_for_hand_part_one(cards))
    value = value.to_i
    {
      hand: hand,
      value: value
    }
  end
end

def parse_input_part_two(input)
  input.lines.map do |line|
    line.strip!
    cards, value = line.split(" ")
    cards = cards.each_char.map { |ch| Card.new(ch) }
    hand = Hand.new(cards, find_type_for_hand_part_two(cards))
    value = value.to_i
    {
      hand: hand,
      value: value
    }
  end
end

def solution(input)
  input
    .sort { |a, b| a[:hand].compare(b[:hand]) }
    .each_with_index.map do |a, i|
      a[:value] * (i + 1)
    end
    .sum
end

def main
  contents = File.read("./input.txt")
  # input = parse_input_part_one(contents)
  # p solution(input)
  input = parse_input_part_two(contents)
  # puts input
  puts solution(input)
end

main
