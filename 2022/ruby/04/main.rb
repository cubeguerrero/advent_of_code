def get_range(input)
  i, j = input.split('-').map(&:to_i)
  i..j
end

def range_fully_overlap?(r1, r2)
  r1.cover?(r2) || r2.cover?(r1)
end

def range_overlap?(r1, r2)
  (r1.include?(r2.begin) || r1.include?(r2.end)) ||
    (r2.include?(r1.begin) || r2.include?(r1.end))
end

def main
  f = File.open(File.join(File.dirname(__FILE__), 'input.txt'))
  # fully_overlapping_pairs_count = 0 - part 1
  overlapping_pairs_count = 0

  f.readlines.each do |line|
    line = line.strip
    assignment1, assignment2 = line.split(',')
    r1 = get_range(assignment1)
    r2 = get_range(assignment2)

    # fully_overlapping_pairs_count += 1 if range_fully_overlap?(r1, r2) - part 2
    overlapping_pairs_count += 1 if range_overlap?(r1, r2)
  end

  puts overlapping_pairs_count
end

main
