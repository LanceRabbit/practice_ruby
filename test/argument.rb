def func (args:)
  p args
end

# func(args: 'hhhh')
# func('hhhh') #wrong number of arguments (given 1, expected 0; required keyword: args) (ArgumentError)


def foo(bar:)
  puts bar
end

foo()
foo('asd')