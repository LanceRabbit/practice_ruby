class TestMethod
  def initialize
    @callbacks = []
    @test = "1234"
  end

  def set_data
    @data ||= test_method
  end

  private

  def test_method
    p "test_method"
    target = "abcd"
    target = @test if @test == "12324"
    target
  end
end

test = TestMethod.new
p test.set_data
p test.set_data