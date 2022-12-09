class Point
  attr_accessor :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def move(direction)
    case direction
    when :up then self.y = y + 1
    when :down then self.y = y - 1
    when :right then self.x = x + 1
    when :left then self.x = x - 1
    else
      raise ArgumentError
    end
  end

  def to_s
    "(x: #{x}, y: #{y})"
  end
end

class T < Point
  attr_reader :visited

  def initialize(x:, y:)
    @visited = { [x, y] => 1 }
    super(x:, y:)
  end

  def follow_point(other)
    return unless need_to_move?(other)

    # store visited
    @visited[[x, y]] = 1 unless @visited.include? [x, y]

    diff_x = other.x - x
    diff_y = other.y - y

    # check if we need to move diagonally
    if diff_x.abs > 0
      if other.x > x # which means the other point is on the right
        move(:right)
      else
        move(:left)
      end
    end

    if diff_y.abs > 0
      if other.y > y
        move(:up)
      else
        move(:down)
      end
    end
  end

  private

  def need_to_move?(other)
    (other.y - y).abs >= 2 || (other.x - x).abs >= 2
  end
end

def parse_line(line)
  dir, count = line.split(' ')
  dir = case dir
        when 'R' then :right
        when 'U' then :up
        when 'D' then :down
        else
          :left
        end

  [dir, count.to_i]
end

# part
def main
  h = Point.new(x: 0, y: 0)
  t1 = T.new(x: 0, y: 0)
  t2 = T.new(x: 0, y: 0)
  t3 = T.new(x: 0, y: 0)
  t4 = T.new(x: 0, y: 0)
  t5 = T.new(x: 0, y: 0)
  t6 = T.new(x: 0, y: 0)
  t7 = T.new(x: 0, y: 0)
  t8 = T.new(x: 0, y: 0)
  t9 = T.new(x: 0, y: 0)

  input = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
  input.readlines.each do |line|
    line.strip!
    dir, count = parse_line(line)
    count.times do
      h.move(dir)
      t1.follow_point(h)
      t2.follow_point(t1)
      t3.follow_point(t2)
      t4.follow_point(t3)
      t5.follow_point(t4)
      t6.follow_point(t5)
      t7.follow_point(t6)
      t8.follow_point(t7)
      t9.follow_point(t8)
    end
  end

  p "Part 1: #{t1.visited.keys.length}"
  p "Part 2: #{t9.visited.keys.length}"
end

main
