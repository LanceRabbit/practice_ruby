
arr = []

# th = Thread.new

# (1..10).each do |i|
#   Thread.new
#     arr.add i
#   end
# end


# data = []
# pages_to_crawl = %w( index about contact )
# pages_to_crawl.each_with_index do |page, index|
#   arr << Thread.new {
#     data << if index > 1
#       page
#     else
#       "#{page} - #{index}"
#     end
#   }
# end

# arr.map(&:join)
# p data

# count = 0
# arr = []

# 10.times do |i|
#   arr[i] = Thread.new {
#       sleep(rand(0)/10.0)
#       Thread.current["mycount"] = count
#       count += 1
#   }
# end

# arr.each {|t| t.join; print t["mycount"], ", " }
# puts "count = #{count}"

puts "use ConditionVariable to control context switch of threads"
mutex = Mutex.new

cv = ConditionVariable.new
a = Thread.new {
   mutex.synchronize {
      puts "A: I have critical section, but will wait for cv"
      cv.wait(mutex)
      puts "A: I have critical section again! I rule!"
   }
}

puts "(Later, back at the ranch...)"

b = Thread.new {
   mutex.synchronize {
      puts "B: Now I am critical, but am done with cv"
      cv.signal
      puts "B: I am still critical, finishing up"
   }
}
a.join
b.join



#
puts "Synchronize Thread"

@num=200
# @mutex=Mutex.new

def buyTicket(num, who)
     @mutex.lock
          p "who: #{who}"
          if @num>=num
               @num=@num-num
               puts "#{@num} you have successfully bought #{num} tickets"
          else
               puts "sorry,no enough tickets"
          end
     @mutex.unlock
end

ticket1=Thread.new 10 do
     10.times do |value|
     ticketNum=15
     buyTicket(ticketNum, 'ticket1')
     sleep 0.01
     end
end

ticket2=Thread.new 10 do
     10.times do |value|
     ticketNum=20
     buyTicket(ticketNum, 'ticket2')
     sleep 0.01
     end
end

# sleep 1
# ticket1.join
# ticket2.join