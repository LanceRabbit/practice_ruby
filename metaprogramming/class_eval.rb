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


module TestCommon
  def self.included(base)
    base.class_eval do
      define_singleton_method :base_attributes do
        base::ATTRS
      end
    end
  end
end

class User
  include TestCommon

  ATTRS = %w(first_name, last_name)
end

class Book
  include TestCommon

  ATTRS = %w(title, desc)
end

p User.base_attributes
p Book.base_attributes



module ErrorUsage
  def self.included(base)
    define_method :base_attributes do
      base::ATTRS
    end
  end
end

class Admin
  include ErrorUsage

  ATTRS = %w(first_name, last_name)
end

class SuperAdmin
  include ErrorUsage

  ATTRS = %w(title, desc)
end

# 這邊會看到結果不如預期.
p Admin.new.base_attributes  # ["title,", "desc"]
p SuperAdmin.new.base_attributes # ["title,", "desc"]


module CorrectUsage
  def self.included(base)
    base.class_eval do
      define_method :base_attributes do
        base::ATTRS
      end
    end
  end
end

class Car
  include CorrectUsage

  ATTRS = %w(first_name, last_name)
end

class SuperCar
  include CorrectUsage

  ATTRS = %w(title, desc)
end

# 要用 class_eval 來處理這一塊, 否則就會覆寫成同一份 base_attributes
p Car.new.base_attributes  # ["first_name,", "last_name"]
p SuperCar.new.base_attributes # ["title,", "desc"]
