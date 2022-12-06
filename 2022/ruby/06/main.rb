require 'set'

def main
  contents = File.read(File.join(File.dirname(__FILE__), 'input.txt')).strip

  i = 0
  j = 13 # j = 3 for part 1
  found = false

  until found
    marker = contents[i..j]
    if Set.new(marker.split('')).length == 14
      found = true
      puts j
      break
    end
    i += 1
    j += 1
  end
end

main
