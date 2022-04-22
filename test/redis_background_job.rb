require 'redis'
require 'json'

# REF: https://hackmd.io/0bzPn3YPRSSxZk8VUpKQ4w

class RedisQueue
  def initialize
    @conn = Redis.new
  end

  def pop
    _, count = @conn.blpop 'example-queue' # 以 Blocking 方式取出資料，如果 LIST 是空的則進入 Blocking 狀態
    CountTask.new(count.to_i)
  end

  def <<(task)
    @conn.rpush 'example-queue', task.count
  end
end

class CountTask
  attr_reader :count

  def initialize(count)
    @count = count
  end

  def perform
    "Task run in #{count}"
  end
end

class Worker
  def initialize(idx)
    @idx = idx
    @thread = nil
    @queue = RedisQueue.new # 因為共用 Connection 會 Blocking 所有人所以先各自建立連線
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

queue = RedisQueue.new
workers = 3.times.map { |idx| Worker.new(idx) }
workers.each(&:run!)

count = 0
loop do
  4.times do
    task = CountTask.new(count)
    count += 1
    queue << task
  end
  sleep 1
end