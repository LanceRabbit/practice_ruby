# Module#included

module MyModule1
  def my_method; 'MyModule1 - hello'; end
end

module MyModule2
  def self.included(base)
    base.class_eval do
      def my_new_method; "MyModule2 - included"; end
    end
  end
end

module MyModule3
  def my_instance_method; 'MyModule3 - instance_method '; end
end

module MyModule4
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def class_method; 'MyModule4 - ClassMethods '; end
  end
end

class MyClass
  include MyModule3
  include MyModule4

  class << self
    include MyModule1
    include MyModule2
  end
end

p MyClass.ancestors
p MyClass.my_method
p MyClass.my_new_method
p MyClass.new.my_instance_method
p MyClass.class_method