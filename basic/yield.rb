# frozen_string_literal: true

arr = %w[ask go want abcd]

def test_1(arr, &block)
  arr.map do |word|
    # next if word == 'go'
    # next if yield word

    word
  end
end

# p test_1(arr) { |word|
#   word == 'go' || -> (word) { |word| word == 'want' }
# }
# p test_1(arr)


def sum(a, *b)
  p "a: #{a}, *b: #{b}"
  a + b.inject(0) { |a, b|
    p "inject_ a: #{a}, b: #{b}"
    a + b
  }
end

sum_10_elements = method(:sum).curry(10)

(1..10).each do |n|
  sum_10_elements = sum_10_elements.call(n)
  puts sum_10_elements
end


class Proc
  def my_curry
    # when my_curry is called: create a new proc and return
    curried = proc do |*partial_args|
      # when curried proc is called: create a closure with partial arguments and then return a new proc/lambda
      l = lambda do |*remaining_args|
        # when the partial rendered curried lambda is called delegate the call to original lambda with closure + current arguments
        actual_args = partial_args + remaining_args
        call(*actual_args)
      end
    end
  end
end
original_lambda = ->(x, y) { p x, y }
p original_lambda
curried_proc = original_lambda.my_curry
p curried_proc
partial_renderd_lambda = curried_proc[1]
p partial_renderd_lambda
partial_renderd_lambda[2]
