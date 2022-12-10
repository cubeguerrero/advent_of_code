class Instruction
  attr_reader :operation, :value

  def self.parse_line(line)
    line.strip!
    i = line.split(' ')
    if i.length == 1
      new(operation: :noop, value: 0)
    else
      new(operation: :add, value: i[1].to_i)
    end
  end

  def initialize(operation:, value:)
    @operation = operation
    @value = value
  end

  def noop?
    operation == :noop
  end

  def to_s
    "operation: #{operation}, value: #{value}"
  end
end

class InstructionRegister
  def initialize
    @register = []
  end

  def add(instruction:)
    if instruction.noop?
      @register.unshift(nil)
    else
      @register.unshift(nil)
      @register.unshift(instruction)
    end
  end

  def pop
    @register.pop
  end

  def to_s
    @register.inspect
  end
end

class Monitor
  attr_reader :screen

  def initialize
    @start_sprite = 0
    @end_sprite = 2
    @screen = []
  end

  def update_sprite(register)
    @start_sprite = (register - 1)
    @end_sprite = @start_sprite + 2
  end

  def update_screen(cycle)
    pos = cycle % 40

    c = if (@start_sprite..@end_sprite).include? pos
          '#'
        else
          '.'
        end

    @screen[cycle] = c
  end

  def print_sprite
    p @start_sprite..@end_sprite
  end

  def print_screen
    rows = [(0...40), (40...80), (80...120), (120...160), (160...200), (200...240)]
    puts rows.map { |r| @screen[r].join('') }.join("\n")
  end
end

class CentralProcessingUnit
  IMPORTANT_CYCLES = [20, 60, 100, 140, 180, 220]

  def initialize(instructions:, instruction_register:, monitor:)
    @instructions = instructions
    @instruction_register = instruction_register
    @monitor = monitor
    @cycle = 0
    @register = 1
  end

  # part 1
  def process
    total = 0
    while @cycle < 240

      total += (@cycle + 1) * @register if IMPORTANT_CYCLES.include? @cycle + 1

      # get instruction and put inside instruction_register
      instruction = @instructions[@cycle]
      @instruction_register.add(instruction:) if instruction

      @monitor.update_screen(@cycle)

      # check instruction register if we need to run in
      if ins = @instruction_register.pop
        @register += ins.value
        @monitor.update_sprite(@register)
      end

      # increase cycle
      @cycle += 1
    end

    total
  end
end

def main
  input_file = 'input.txt'

  instructions = File.open(File.join(File.dirname(__FILE__), input_file))
  instructions = instructions.readlines.map { |line| Instruction.parse_line(line) }
  instruction_register = InstructionRegister.new
  monitor = Monitor.new
  cpu = CentralProcessingUnit.new(instructions:, instruction_register:, monitor:)

  total = cpu.process
  puts "Part 1: Total is #{total}"

  puts 'Part 2:'
  monitor.print_screen
end

main
