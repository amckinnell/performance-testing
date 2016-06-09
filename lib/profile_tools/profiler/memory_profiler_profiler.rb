require "memory_profiler"

module ProfileTools
  module Profiler
    #
    # Uses memory_profiler to profile the supplied block.
    #
    class MemoryProfilerProfiler
      def initialize(results_directory)
        @results_path = File.join(results_directory, "memory_profile.txt")
      end

      def profile
        report = MemoryProfiler.report do
          yield
        end

        report.pretty_print(to_file: @results_path)
      end
    end
  end
end
