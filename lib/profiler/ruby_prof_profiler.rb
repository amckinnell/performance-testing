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
    end
  end
end
