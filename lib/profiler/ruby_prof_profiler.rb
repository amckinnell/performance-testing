require "ruby-prof"

module Profiler
  #
  # Uses RubyProf to profile the supplied block.
  #
  class RubyProfProfiler
    def initialize(results_directory)
      @results_directory = results_directory
    end

    def profile
      result = RubyProf.profile do
        yield
      end

      printer = RubyProf::MultiPrinter.new(result)
      printer.print(path: @results_directory, profile: "ruby_prof")

      rename_results_for_qcachegrind
    end

    private

    def rename_results_for_qcachegrind
      File.rename(
        File.join(@results_directory, "ruby_prof.grind.dat"),
        File.join(@results_directory, "callgrind.dat")
      )
    end
  end
end
