module BeforeAction
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def before_action(method_name, options)
      action_module = Module.new do
        send :define_method, options[:for] do |*args, &block|
          send method_name

          super(*args, &block)
        end
      end

      prepend action_module
    end
  end
end

class Speaker
  include BeforeAction

  before_action :chinese_self_intro, for: :speak

  def speak
    puts 'I am speaking...'
  end

  private

  def chinese_self_intro
    puts 'Hello, I come from china.'
  end
end

# p Speaker.ancestors
# Speaker.new.speak

module ServiceDebugger
  def run
    p 'ServiceDebugger'
    super
  end
end

class ServicePrepend
  prepend ServiceDebugger
  def run
    self.class
  end
end

p ServicePrepend.ancestors
p ServicePrepend.new.run