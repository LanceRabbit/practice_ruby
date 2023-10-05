
p "test"
case ARGV.first
when "123"
  p "hello"
when "abc"
  p "world"
else
  raise "not support"
end

