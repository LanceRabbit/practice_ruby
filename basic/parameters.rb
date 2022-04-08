
class TestParameter
  def self.method_1(first, second="abcd", third: [])
    p "first: #{first}"
    p "second: #{second}"
    p "third: #{third}"
    nil
  end
end

# p TestParameter.method_1("123", "abcd", %w(hi la bss))  #  wrong number of arguments (given 3, expected 1..2) (ArgumentError)
# p TestParameter.method_1("123", "lulu", third: %w(hi la bss))

# p TestParameter.method_1("123", third: %w(hi la bss)

class ArrayParameter
  def self.method_1(a, ids: [])
    p "first: #{ids}"
    nil
  end
end
# ArrayParameter.method_1(1,2,3)
# ArrayParameter.method_1(%w(a b c))

ArrayParameter.method_1("a", ids: Array(1))

class TransforToArray
  def self.method_1(*ids)
    p "first: #{ids}"
    nil
  end
end
TransforToArray.method_1(1) # "first: [1]"
TransforToArray.method_1([1,2,3]) # "first: [[1, 2, 3]]"