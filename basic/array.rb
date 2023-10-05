list = (1..10).reduce([]) do |arr, num|
  arr << num
  arr
end

# p list


# params[:sub_order] = {
#   "sub_order.id" => {
#     "sub_ordero_item.id1" => { c: '', q: '', ret..: '', or..: '' },
#     "sub_ordero_item.id2" => { c: '', q: '', ret..: '', or..: '' }
#   },
#   "sub_order.id2" => {
#     "sub_ordero_item.id1" => { c: '', q: '', ret..: '', or..: '' },
#     "sub_ordero_item.id2" => { c: '', q: '', ret..: '', or..: '' }
#   }
# }

orders = {
  "sub_order_1": {
    "sub_order_item": {
      "return_eslite_point": 1
    }
  },
  "sub_order_2": {
    "sub_order_item": {
      "return_eslite_point": 2
    }
  },
  "sub_order_3": {
    "sub_order_item": {
      "return_eslite_point": -1
    }
  },
}

# target = orders.values.map { _1.values.map { |item| item[:return_eslite_point]}}.flatten
# p target
# p target.any? {|data| data.negative? }



p list.reject{|data| data == 13 }

p list.delete_if{|data| data == 13 }