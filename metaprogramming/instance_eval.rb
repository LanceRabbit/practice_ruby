class Target
end

target = Target

Target.instance_eval do
  def instance_eval_method
    "instance_eval_method"
  end
end
p Target.instance_eval_method


class_target = Target
class_target.class_eval do
  def class_eval_method
    "class_eval_method"
  end
end
p class_target.new.class_eval_method
p Target.instance_methods(false)
p Target.methods(false)
#"instance_eval_method"
#"instance_eval_method"
#"class_eval_method"