def initial_state
  [
    %w[W L S],
    %w[J T N Q],
    %w[S C H F J],
    %w[T R M W N G B],
    %w[T R L S D H Q B],
    %w[M J B V F J R L],
    %w[D W R N J M],
    %w[B Z T F H N D J],
    %w[H L Q N B F T]
  ]
end

class Move
  attr_reader :count, :from, :to

  def initialize(count, from, to)
    @count = count.to_i
    @from = from.to_i
    @to = to.to_i
  end

  def to_s
    "Inside class: move #{count} from #{from} to #{to}"
  end
end

def parse_line(line)
  parsed = line.split(' ')
  Move.new(parsed[1], parsed[3], parsed[5])
end

def main
  moves = File.open(File.join(File.dirname(__FILE__), 'move_input.txt'))
  state = initial_state
  moves.readlines.each do |line|
    move = parse_line(line)
    count = move.count
    from = state[move.from - 1]
    current = []
    count.times do
      popped = from.pop
      current.unshift(popped)
    end
    state[move.to - 1] = state[move.to - 1] + current
  end

  p state.map { |a| a.last }.join('')
end

main
