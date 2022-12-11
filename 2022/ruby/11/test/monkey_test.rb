require 'minitest/autorun'

require 'monkey'

class MonkeyTest < Minitest::Test
  def setup
    @input = %(Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3
      )

    @second_input = %(Monkey 0:
      Starting items: 79, 98
      Operation: new = old * old
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3
      )
  end

  def test_parse
    monkey = Monkey.parse(@input)

    assert monkey.name == 0
    assert monkey.items.include? 79
    assert monkey.items.include? 98
    assert monkey.operation == :*
    assert monkey.operation_value == 19
    assert monkey.divisible_by == 23
    assert monkey.true_to == 2
    assert monkey.false_to == 3

    monkey2 = Monkey.parse(@second_input)
    assert monkey2.operation == :**
    assert monkey2.operation_value == 2
  end

  def test_do_inspection
    monkey = Monkey.parse(@input)

    assert monkey.do_inspection == [[500, 3], [620, 3]]
    assert monkey.items.length == 0
    assert monkey.inspected_count == 2
  end

  def test_add_item
    monkey = Monkey.parse(@input)

    monkey.add_item(90)
    assert monkey.items.length == 3
    assert monkey.items == [79, 98, 90]
  end
end
