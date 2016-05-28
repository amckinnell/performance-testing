require "results_directory"
require "profiler/ruby_profiler"

#
# Create a profiler that accepts a block to profile.
#
module ProfilerFactory
  def self.create(profiler:, results_dir:)
    case profiler
    when :ruby_profiler
      Profiler::RubyProfiler.new(results_dir)
    else
      raise "Unknown profiler: #{profiler}"
    end
  end
end
