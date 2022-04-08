# REF: https://www.youtube.com/watch?v=BV1-Z38ZWQU
#  The Functional Rubyist by Joe Leo
# Currying
## 1 function with many arguments
## into many function, each with 1 argument
## 做法有點像 Higher Order Componet.

base_method = -> (a, b) { a + b }

p base_method.(4, 5) # 9
p base_method.("a", "b") # "ab"

curried_add = -> (a) { -> (b) { a + b } }

# unmarked for detail
# curried_add.(4, 5) # wrong number of arguments

p curried_add.(4).(5) # 9

curried_base_method = base_method.curry
p curried_base_method.(4).(5) # 9 is work
p curried_base_method.(4, 5) # 9 is work
p curried_base_method.call(4).call(5) # 9 is work

curried_base_method_4 = curried_base_method.call(4)
curried_base_method_9 = curried_base_method.call(9)
p curried_base_method_4.call(3) # 7
p curried_base_method_9.call(11) # 20