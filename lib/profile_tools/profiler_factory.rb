require "profile_tools/results_directory"
require "profile_tools/profiler/benchmark_profiler"
require "profile_tools/profiler/memory_profiler_profiler"
require "profile_tools/profiler/ruby_prof_profiler"

module ProfileTools
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
end
