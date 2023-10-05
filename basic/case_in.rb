

# case [type, piece_qty, group_qty]
# in ['piece_count', limit_qty, _] if limit_qty.to_i > 0
#   qty > limit_qty ? qty : limit_qty
# in ['group_count', _, limit_qty] if limit_qty.to_i > 0
#   (qty / limit_qty) * limit_qty
# else
#   qty
# end


first = "c"
second = "b"
last = "a"


case [first, second, last]
in [ "a", "b", "c" ] if first == "a"
  p "first case"
in [ "c", "b", "a" ] if first == "c"
  p "second case"
else
  p "last"
end


# case [first]
# in "a" if second == "b"
#   p "111"
# else
#   p "end"
# end
