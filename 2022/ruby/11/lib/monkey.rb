class Item
  attr_accessor :original_value, :current_value

  def initialize(value:)
    @original_value = value
    @current_value = value
  end

  def reset
    @current_value = @original_value
  end
end

class Monkey
  attr_reader :name, :items, :operation, :operation_value, :divisible_by, :true_to, :false_to, :inspected_count

  def self.parse(input)
    information = {}
    input.lines.each do |line|
      line.strip!
      if line.include? 'Monkey'
        _, num = line.split(' ')
        num = num[0...-1].to_i
        information[:name] = num
      elsif line.include? 'Starting'
        _, nums = line.split(':')
        information[:items] = nums.split(',').map { |i| Item.new(value: i.strip.to_i) }
      elsif line.include? 'Operation'
        _, operation, operation_value = line.split('=').last.split(' ')
        operation.strip!
        operation_value.strip!

        if operation_value.include? 'old'
          if operation == '*'
            operation = '**'
            operation_value = 2
          else # assume by default addition
            operation = '*'
            operation_value = 2
          end
        end

        operation = operation.to_sym
        operation_value = operation_value.to_i
        information[:operation] = operation
        information[:operation_value] = operation_value
      elsif line.include? 'Test'
        _, v = line.split('by')
        v.strip!
        information[:divisible_by] = v.to_i
      elsif line.include? 'true'
        _, v = line.split('monkey')
        v.strip!
        information[:true_to] = v.to_i
      elsif line.include? 'false'
        _, v = line.split('monkey')
        v.strip!
        information[:false_to] = v.to_i
      end
    end

    new(**information)
  end

  def do_inspection
    x = items
    reset_items
    x.map do |item|
      @inspected_count += 1
      # start to worry
      new_value = [item.current_value, operation_value].reduce(&operation)
      item.current_value = new_value
      # Part 1: decrease worry
      # item.current_value = new_value / 3

      # Part 2:
      item.current_value = new_value % (2 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23 * 29)

      if item.current_value % divisible_by == 0
        [item, true_to]
      else
        [item, false_to]
      end
    end
  end

  def to_s
    "Monkey #{name} inspected items #{@inspected_count} times."
  end

  def add_item(item)
    items << item
  end

  def reset_items
    @items = []
  end

  private

  def initialize(name:, items:, operation:, operation_value:, divisible_by:, true_to:, false_to:)
    @name = name
    @items = items
    @operation = operation
    @operation_value = operation_value
    @true_to = true_to
    @false_to = false_to
    @divisible_by = divisible_by
    @inspected_count = 0
  end
end
