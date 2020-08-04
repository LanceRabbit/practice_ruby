# ref: https://www.reddit.com/r/ruby/comments/9var5n/converting_a_string_number_to_an_integer_without/
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('to_i') { "123".to_i }
  x.report('each_char') { "123".each_char.map { |c| case c; when '1' then 1; when '2' then 2; when '3' then 3; end; }.reduce(0) { |a, i| a * 10 + i } }
  x.report('eval') { eval("123") }
  x.report('Integer') { Integer("123") }
  x.report('eval.gsub') { eval("123".gsub(/[^\d+]/,'')) }
  x.compare!
end
