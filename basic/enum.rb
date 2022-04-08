class Food
  include Enumerable

  def initialize(*list)
    @list = list
  end

  def each(&block)
    p "each"
    @list.each(&block)
  end
end

test = Food.new("hamburger", "hot dog", "noodle", "black tea")
p "before call method"
p test.map(&:upcase)
