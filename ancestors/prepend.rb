module ServiceDebugger
  def run(args)
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Service run start: #{args.inspect}"
    result = super
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Exceute times: #{ending - starting}"
    puts "Service run finished: #{result}"
  end
end

class ServicePrepend
  prepend ServiceDebugger

  # perform some real work
  def run(args)
    args.each do |arg|
      p arg
      sleep 1
    end
    {result: "ok"}
  end
end

class ServiceInclude
  include ServiceDebugger

  # perform some real work
  def run(args)
    args.each do |arg|
      p arg
      sleep 1
    end
    {result: "ok"}
  end
end


p ServicePrepend.ancestors
# [ServiceDebugger, ServicePrepend, Object, Kernel, BasicObject]

p ServiceInclude.ancestors
# [ServiceInclude, ServiceDebugger, Object, Kernel, BasicObject]

# ServicePrepend 執行 run 時, 會先執行 ServiceDebugger 的 run
p 'ServicePrepend'
ServicePrepend.new.run(["s","d"])

p '~~~~~~~~~~~~~'
p 'ServiceInclude'
# ServiceInclude 執行 run 時, 不會執行到 ServiceDebugger 的 run
ServiceInclude.new.run(["s","d"])
