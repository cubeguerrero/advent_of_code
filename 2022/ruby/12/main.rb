ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

def get_value(v)
  if v == 'S'
    ALPHABET.index('a')
  elsif v == 'E'
    ALPHABET.index('z')
  else
    ALPHABET.index(v)
  end
end

def get_grid(input)
  input.readlines.map do |line|
    line.strip!
    line.split('')
  end
end

def find_starting_position(grid)
  grid.each_with_index do |row, i|
    if row.include? 'S'
      j = row.index('S')
      return [i, j]
    end
  end

  [0, 0]
end

def find_path(row, col, grid, visited = [], step = 0)
  max = grid.length * grid[0].length

  return step if visited.include? [row, col]

  if grid[row][col] == 'E'
    puts "At E: #{step}"
    return step
  end

  visited << [row, col]
  current_v = get_value(grid[row][col])

  # get top
  top_row = row - 1
  top = if top_row >= 0
          v = get_value(grid[top_row][col])
          if v - current_v <= 1
            find_path(top_row, col, grid, visited, step + 1)
          else
            max
          end
        else
          max
        end

  # get bottom
  bottom_row = row + 1
  bottom = if bottom_row < grid.length
             v = get_value(grid[bottom_row][col])
             if v - current_v <= 1
               find_path(bottom_row, col, grid, visited, step + 1)
             else
               max
             end
           else
             max
           end

  # get left
  left_col = col - 1
  left = if left_col >= 0
           v = get_value(grid[row][left_col])
           if v - current_v <= 1
             find_path(row, left_col, grid, visited, step + 1)
           else
             max
           end
         else
           max
         end

  # get right
  right_col = col + 1
  right = if right_col < grid[0].length
            v = get_value(grid[row][right_col])
            if v - current_v <= 1
              find_path(row, right_col, grid, visited, step + 1)
            else
              max
            end
          else
            max
          end

  [top, bottom, left, row].flatten
end

def main
  input_filename = 'test_input.txt'
  input = File.open(File.join(File.dirname(__FILE__), input_filename))
  grid = get_grid(input)
  i, j = find_starting_position(grid)
  p find_path(i, j, grid)
end

main
