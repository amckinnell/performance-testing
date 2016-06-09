require "benchmark"

module ProfileTools
  module Profiler
    #
    # Uses Benchmark module to profile the supplied block.
    #
    class BenchmarkProfiler
      def initialize(results_directory)
        @results_path = File.join(results_directory, "benchmark.txt")
      end

      def profile
        File.open(@results_path, "w") do |file|
          file.write(Benchmark::CAPTION)
          file.write(Benchmark.measure { yield })
        end

        File.readlines(@results_path).each { |line| puts line }
      end
    end
  end
end
