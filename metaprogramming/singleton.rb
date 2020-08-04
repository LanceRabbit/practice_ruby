# singleton class
# singleton method
# class method

class C
  def a_method
    'C#a_method()'
  end

  def self.self_a_method
    'C#self.a_method()'
  end
end
class D < C; end

# p Class.singleton_class.superclass
p D.singleton_class.ancestors
# class method is also singleton metohd!!
p D.singleton_methods # [:self_a_method]
# p D.new.singleton_class
# p D.new.singleton_class

obj = D.new

p obj.singleton_methods # []
p obj.a_method
p obj.class
p obj.singleton_class
p obj.singleton_class.superclass
class << obj
  def a_singleton_method
    'obj#a_singleton_method()'
end end
p obj.singleton_methods # [:a_singleton_method]