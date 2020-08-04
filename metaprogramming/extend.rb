# Module#included
# Module#extended
# Module#prepended
# Class#inherited

module MyModule1
  def my_method; 'MyModule1 - hello'; end
end

module MyModule2
  def self.extended(base)
    def base.my_new_method; "MyModule2 - extended"; end
  end
end

class MyClass
  extend MyModule1
end

p MyClass.ancestors
p MyClass.my_method
p MyClass.extend(MyModule2).my_new_method
