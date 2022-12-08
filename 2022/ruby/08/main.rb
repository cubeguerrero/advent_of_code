def create_grid(f)
  f.readlines.map do |line|
    line.strip!
    line.split('').map(&:to_i)
  end
end

def clone_grid(grid)
  clone = Array.new(grid.length)
  grid.each_with_index do |r, i|
    clone[i] = r.dup
  end
  clone
end

def create_scenic_grid(grid)
  clone = clone_grid(grid)
  clone[0] = clone[0].map { 0 }
  clone[clone.length - 1] = clone[clone.length - 1].map { 0 }
  (0..(clone.length - 1)).each do |r|
    l = clone[r].length - 1
    clone[r][0] = 0
    clone[r][l] = 0
  end
  clone
end

def part2(grid)
  scenic_scores = create_scenic_grid(grid)

  max_j = grid.length - 2 # rows
  max_i = grid[0].length - 2 # cols
  (1..max_j).each do |row| # rows
    (1..max_i).each do |col|
      score = get_scenic_score(row, col, grid)
      scenic_scores[row][col] = score
    end
  end

  puts "Part 2: #{scenic_scores.map { |r| r.max }.max}"
end

def get_scenic_score(row, col, grid)
  # from top
  top = get_top_score(row, col, grid)
  bottom = get_bottom_score(row, col, grid)
  left = get_left_score(row, col, grid)
  right = get_right_score(row, col, grid)

  top * bottom * left * right
end

def get_top_score(row, col, grid)
  top = 1
  t = row - 1
  while t > 0 && grid[t][col] < grid[row][col]
    top += 1
    t -= 1
  end

  top
end

def get_bottom_score(row, col, grid)
  bottom = 1
  b = row + 1

  while b < grid.length - 1 && grid[b][col] < grid[row][col]
    bottom += 1
    b += 1
  end

  bottom
end

def get_right_score(row, col, grid)
  right = 1
  r = col - 1

  while r > 0 && grid[row][r] < grid[row][col]
    right += 1
    r -= 1
  end

  right
end

def get_left_score(row, col, grid)
  left = 1
  l = col + 1

  while l < (grid[0].length - 1) && grid[row][l] < grid[row][col]
    left += 1
    l += 1
  end

  left
end

def part1(grid)
  height = grid.length
  width = grid[0].length

  total = height + (width - 1) + (height - 1) + (width - 2)
  total += check_grid(grid)

  puts "Part 1: #{total}"
end

def check_grid(grid)
  total = 0
  max_j = grid.length - 2 # rows
  max_i = grid[0].length - 2 # cols
  (1..max_j).each do |row| # rows
    (1..max_i).each do |col|
      next unless visible?(row, col, grid)

      total += 1
    end
  end

  total
end

def visible?(row, col, grid)
  visible_from_top?(row, col,
                    grid) || visible_from_bottom?(row, col,
                                                  grid) || visible_from_left?(row, col,
                                                                              grid) || visible_from_right?(
                                                                                row, col, grid
                                                                              )
end

def visible_from_top?(row, col, grid)
  m = row - 1
  (0..m).all? { |r| grid[r][col] < grid[row][col] }
end

def visible_from_bottom?(row, col, grid)
  m = grid.length - 1
  ((row + 1)..m).all? { |r| grid[r][col] < grid[row][col] }
end

def visible_from_left?(row, col, grid)
  m = col - 1
  (0..m).all? { |c| grid[row][c] < grid[row][col] }
end

def visible_from_right?(row, col, grid)
  m = grid[0].length - 1
  ((col + 1)..m).all? { |c| grid[row][c] < grid[row][col] }
end

def main
  f = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
  grid = create_grid(f)
  part1(grid)
  part2(grid)
end

main
