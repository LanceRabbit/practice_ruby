# REF: https://6ftdan.com/allyourdev/2017/05/13/dont-use-objects-as-hash-keys-in-ruby/

A = Object.new

def a
  :result
end

def value_of
  [1]
end

hash_of = {
  a: [1],
  "a" => [1],
  result: [1],
  A => [1]
}

require "benchmark/ips"
Benchmark.ips do |x|
  x.report("Method Call") do
    value_of()
  end

  x.report("Hash w/ Symbol key") do
    hash_of[:a]
  end

  x.report("Hash w/ String key") do
    hash_of["a"]
  end

  x.report("Hash w/ Method key") do
    hash_of[a]
  end

  x.report("Hash w/ Constant key") do
    hash_of[A]
  end

  x.compare!
end