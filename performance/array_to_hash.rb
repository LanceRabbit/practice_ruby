# ref: https://gist.github.com/godfat/1065318
require 'benchmark/ips'

FooBar = Struct.new(:foo, :bar)
data   = (0..9999).map{ |i| FooBar.new(i, i+1) }

Benchmark.ips do |x|
  x.report('Hash+map') { 5000.times { Hash[data.map {|d| [d.foo, d.bar]} ] } }
  x.report('inject(fold)') { 5000.times{ data.inject({}){|h, d| h[d.foo] = d.bar; h }}}
  x.compare!
end
