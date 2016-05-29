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

      # Rename because qcachegrind is looking for callgrind.* as the filename.
      File.rename(File.join(@results_directory, "ruby_prof.grind.dat"),
        File.join(@results_directory, "callgrind.dat"))
    end
  end
end
