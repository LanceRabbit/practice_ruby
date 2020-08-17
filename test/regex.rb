str = "your +example string@ here"

# Between 1st + and 1st @:
regex = /\+(.*?)@/
# Between 1st + and last @:
regex = /\+(.*)@/
# Between last + and last @:
regex = /.*\+(.*)@/
# Between last + and 1st @:
regex = /.*\+(.*?)@/
# Fetch the value
p str[regex, 1]
# or
p str.slice(regex, 1)
# "example string"


a = "foo.bar.size.split('.').last"
puts a.split(/\.(?=[\w])/)
# ["foo", "bar", "size", "split('.')", "last"]


target = "1234560111111-44"
regex = /\d+[0]{1}(\d+)-(\d+)/
p target.slice(regex, 0) # 1234560111111-44
p target.slice(regex, 1) # 111111
p target.slice(regex, 2) # 44
