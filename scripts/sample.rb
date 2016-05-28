#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../lib")

require "profiler_factory"

def slow_task
  5000.times.each do |i|
    puts "Loop counter: #{i}"
  end
end

profiler_tag = :ruby_profiler

results_dir = ResultsDirectory.new(results_dir: "../profile_results").create(tag: profiler_tag)
profiler = ProfilerFactory.create(profiler: profiler_tag, results_dir: results_dir)

profiler.profile { slow_task }
