class Base
  def self.meta_instance_method &block
    define_method "ins", block
  end

  def self.meta_class_method &block
    define_singleton_method "cls", block
  end
end

class Child < Base
  meta_instance_method do
    "This is meta_instance_method"
  end

  meta_class_method do
    "This is meta_class_method"
  end

  def method_missing(m)
    self.class.send(:define_method, "missing") do
      "method_missing"
    end
  end
end

puts Child.new.ins
puts Child.cls
puts Child.new.missing
