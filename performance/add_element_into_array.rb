require 'benchmark/ips'

# ruby 2.7.5
#
#  Warming up --------------------------------------
#         Array#concat    87.000  i/100ms
#              Array#+     1.000  i/100ms
#   Array#<<, #flatten     1.000  i/100ms
#             Array#<<    79.000  i/100ms
# Array#push, #flatten     1.000  i/100ms
# Calculating -------------------------------------
#         Array#concat    870.535  (± 2.5%) i/s -      4.350k in   5.000498s
#              Array#+      2.592  (± 0.0%) i/s -     13.000  in   5.028978s
#   Array#<<, #flatten      0.083  (± 0.0%) i/s -      1.000  in  12.037625s
#             Array#<<    890.582  (± 4.0%) i/s -      4.503k in   5.065271s
# Array#push, #flatten      0.083  (± 0.0%) i/s -      1.000  in  11.981127s
#
# Comparison:
#             Array#<<:      890.6 i/s
#         Array#concat:      870.5 i/s - same-ish: difference falls within error
#              Array#+:        2.6 i/s - 343.56x  slower
# Array#push, #flatten:        0.1 i/s - 10670.18x  slower
#   Array#<<, #flatten:        0.1 i/s - 10720.50x  slower

RANGE = (0..10_000).freeze

def concat
  array = []
  RANGE.each { |number| array.concat(Array.new(10, number)) }
end

def plus
  array = []
  RANGE.each { |number| array += Array.new(10, number) }
end

def append_flatten
  array = []
  RANGE.each { |number| (array << Array.new(10, number)).flatten! }
end

def append
  array = []
  RANGE.each { |number| (array << Array.new(10, number)) }
end

def push_flatten
  array = []
  RANGE.each { |number| array.push(Array.new(10, number)).flatten! }
end

Benchmark.ips do |x|
  x.report('Array#concat') { concat }
  x.report('Array#+')      { plus }
  x.report('Array#<<, #flatten') { append_flatten }
  x.report('Array#<<') { append }
  x.report('Array#push, #flatten') { push_flatten }
  x.compare!
end
