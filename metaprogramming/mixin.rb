# https://stackoverflow.com/questions/39453741/ruby-what-class-gets-a-method-when-there-is-no-explicit-receiver

# https://stackoverflow.com/questions/61669750/ruby-self-extended-gets-called-as-instance-method


module Module1
  def fun1
      puts "fun1 from Module1"
  end

  def self.included(base)
      def base.fun2
          puts "fun2 from Module1"
      end
  end

  def self.extended(base)
    puts "self::#{self}"
    puts "extended from Module1"
    # implicit contexts in Ruby.
    # def fun3
    #   puts "fun3 from Module1"
    # end
    # base.fun3 is
    def base.fun3
      puts "fun3 from Module1"
    end
  end

end

module Module2
  def foo
      puts "foo from Module2"
  end

  def self.extended(base)
    puts "extended from Module2"
      def bar
          puts "bar from Module2"
      end
  end
end


class Test
  include Module1
  extend Module2
  def abc
    puts "abc form Test"
  end
end

class Test2
  extend Module1
end

p Test.instance_methods - Class.instance_methods
p Test2.methods - Class.methods

Test.new.fun3

# Test.new.abc #=> abc form Test

# Test.new.fun1 #=> fun1 from Module1

# Test.new.fun2 #=> fun2 from Module1

# Test.foo #=> foo from Module2

# Test.bar #=> bar from Module2

# Test.new.fun3 #=> NoMethodError (undefined method `fun3' ..)

Test2.fun3 #=> fun3 from Module1