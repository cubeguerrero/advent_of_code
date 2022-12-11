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
        information[:items] = nums.split(',').map { |i| i.strip.to_i }
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
      item = [item, operation_value].reduce(&operation)
      # decrease worry
      item /= 3
      if item % divisible_by == 0
        [item, true_to]
      else
        [item, false_to]
      end
    end
  end

  def to_s
    "Monkey #{name}: #{items.inspect}"
  end

  def add_item(item)
    items << item.to_i
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
