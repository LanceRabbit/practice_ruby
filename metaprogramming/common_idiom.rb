# frozen_string_literal: true

p 'Self Yield'
class Person
  attr_accessor :name, :surname

  def initialize
    yield self
  end
end
joe = Person.new do |p|
  p.name = 'Joe'
  p.surname = 'Smith'
end

p joe

