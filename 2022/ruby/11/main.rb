require_relative './lib/monkey'

def main
  filename = 'input.txt'
  input = File.read(File.join(File.dirname(__FILE__), filename))
  monkeys = input.split("\n\n").map { |i| Monkey.parse(i) }

  rounds = 10_000

  rounds.times do |n|
    puts "Round #{n + 1}"
    monkeys.each do |monkey|
      puts "Monkey #{monkey.name} doing inspection"
      to_distribute = monkey.do_inspection
      to_distribute.each do |item|
        i, to = item
        m = monkeys.select { |m| m.name == to }.first
        m.add_item(i)
      end
    end

    puts monkeys
  end

  two_highest = monkeys.map { |m| m.inspected_count }.sort.last(2)
  puts "#{two_highest.reduce(&:*)}"
end

main
