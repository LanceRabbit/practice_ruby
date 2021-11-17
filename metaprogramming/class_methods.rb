# frozen_string_literal: true

require 'forwardable'

# module Fudousan
#   module Importer
#     module Referenceable
#       def self.included(base)
#         base.extend(Forwardable)
#         base.extend(ClassMethods)
#       end

#       module ClassMethods
#         def reference(field, aka: nil, reject_if: nil)
#           instance_var = "@#{field}"

#           define_method field do
#             return instance_variable_get(instance_var) if instance_variable_defined?(instance_var)

#             ref_val = instance_variable_get(:@realestate_article).send(aka || field)
#             ref_val = nil if reject_if.respond_to?(:call) && reject_if.call(ref_val)
#             instance_variable_set(instance_var, ref_val)
#           end
#         end
#       end
#     end
#   end
# end



module Role
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def test(object)
      class_eval <<-METHODS, __FILE__, __LINE__ + 1
        def #{object.to_s}?(name)
          name == '#{object.to_s}'
        end
        p '#{object}'
      METHODS
    end
  end
end

module Character
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    ROLES = ["junior", "intermediate", "senior"]
    ROLES.map do |object|
      class_eval <<-METHODS, __FILE__, __LINE__ + 1
        def #{object.to_s}?(name)
          name == '#{object.to_s}'
        end
        p '#{object}'
      METHODS
    end
  end
end

class Engineer
  include Character
end


class User
  include Role
  ROLES = ["admin", "normal", "premium"]
  ROLES.map do |mapping|
    test mapping.to_sym
  end
end

class Animal
  include Role
  ROLES = ["cat", "dog", "duck"]
  ROLES.map do |mapping|
    test mapping.to_sym
  end
end

# p User.new.methods

# p User.new.admin?('admin')

p Animal.duck?('admin')

# p Engineer.junior?('junior1')