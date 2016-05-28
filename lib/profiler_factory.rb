require "results_directory"
require "profiler/benchmark_profiler"
require "profiler/memory_profiler_profiler"
require "profiler/ruby_prof_profiler"

#
# Create a profiler that accepts a block to profile.
#
module ProfilerFactory
  def self.create(profiler:, results_dir:)
    case profiler
    when :benchmark
      Profiler::BenchmarkProfiler.new(results_dir)

    when :memory_profiler
      Profiler::MemoryProfilerProfiler.new(results_dir)

    when :ruby_prof
      Profiler::RubyProfProfiler.new(results_dir)

    else
      raise "Unknown profiler: #{profiler}"
    end
  end
end
