



class A
  def call_method(name)
    p self.class.method_defined? "method_#{name}"
    send("method_#{name}") if self.class.method_defined? "method_#{name}"
    # send("method_#{name}") if method_defined? "method_#{name}"
  end

  def method_test
    p "TEst"
  end
end

A.new.call_method("test")
A.new.call_method("test1")