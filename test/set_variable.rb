class TestMethod
  def initialize
    @callbacks = []
    @test = '1234'
  end

  def set_data
    @data ||= test_method
  end

  def call
    flow
  end

  private

  def test_data
    @test_data = { abc: 'first', efg: 'second' }
  end

  def flow
    abc
    efg
  end

  def abc
    p test_data.object_id
    test_data[:abc]
  end

  def efg
    p test_data.object_id
    test_data[:efg]
  end

  def test_method
    p 'test_method'
    target = 'abcd'
    target = @test if @test == '12324'
    target
  end
end

test = TestMethod.new
# p test.set_data
p test.call

class Without
  attr_accessor :data

  def set_data
    @data ||= test_method
  end

  private

  def test_method
    p 'call test method'
    'test_method'
  end
end

with = Without.new
with.set_data
with.set_data
with.set_data

