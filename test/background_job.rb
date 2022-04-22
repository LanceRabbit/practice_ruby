# REF: https://hackmd.io/0bzPn3YPRSSxZk8VUpKQ4w
# Author: elct9620

class Task
  def initialize(*args, &block)
    @args = args
    @proc = block
  end

  def perform
    @proc.call @args
  end
end

class Worker
  def initialize(idx, queue)
    @idx = idx
    @thread = nil
    @queue = queue
  end

  def run!
    return unless @thread.nil?

    @thread = Thread.new do
      loop do
        task = @queue.pop
        ret = task.perform
        puts "Worker #{@idx} run: #{ret}"
      end
    end
  end
end

queue = Queue.new
workers = 3.times.map { |idx| Worker.new(idx, queue) }
workers.each(&:run!)
  sleep 1
# count = 0
# loop do
  20.times do |count|
    task = Task.new(count) { |args| "Task run #{args[0]}" }
    # count += 1
    queue << task
  end
  sleep 1
# end