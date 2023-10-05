# frozen_string_literal: true

require "benchmark/ips"

data_array = (1..100_000).to_a.map(&:to_s)

# 在陣列中隨機選擇一個索引位置，並將 'target' 字串存儲在該位置
target_index = rand(100_000)
data_array[target_index] = 'target'

Benchmark.ips do |bm|
  bm.report('#any?') do
    50.times { data_array.any?('target') }
  end

  bm.report('#include?') do
    50.times { data_array.include?('target') }
  end

  bm.compare!
end
